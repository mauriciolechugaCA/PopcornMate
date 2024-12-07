import 'package:flutter/material.dart';
import 'package:popcornmate_app/models/resulttrendingmovies.dart';
import 'package:popcornmate_app/models/moviedetails.dart';
import 'package:popcornmate_app/services/database_helper.dart';
import 'package:popcornmate_app/api/api.dart';
import 'package:popcornmate_app/theme/colors.dart';

class MovieDetailsScreen extends StatefulWidget {
  final ResultTrendingMovies movie; // The selected movie object

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper(); // Database helper instance
  bool _isFavorite = false; // Tracks if the movie is marked as favorite
  MovieDetails? _movieDetails; // Detailed information about the movie
  bool _isLoading = true; // Indicates if data is still loading

  @override
  void initState() {
    super.initState();
    _checkIfFavorite(); // Check if the movie is already a favorite
    _fetchMovieDetails(); // Fetch detailed movie information
  }

  /// Checks if the movie is already marked as favorite in the database.
  Future<void> _checkIfFavorite() async {
    final isFav = await _dbHelper.isFavorite(widget.movie.id); // Check favorite status
    setState(() {
      _isFavorite = isFav; // Update the favorite status
    });
  }

  /// Fetches detailed information about the movie from the API.
  Future<void> _fetchMovieDetails() async {
    try {
      Api api = Api(); // Instantiate the API helper class
      MovieDetails details = await api.getMovieDetails(widget.movie.id); // Fetch movie details
      setState(() {
        _movieDetails = details; // Update the movie details
        _isLoading = false; // Set loading flag to false
      });
    } catch (e) {
      print('Error fetching movie details: $e'); // Log the error
      setState(() {
        _isLoading = false; // Set loading flag to false even if there's an error
      });
    }
  }

  /// Toggles the favorite status of the movie.
  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      // If the movie is already a favorite, remove it from the database
      await _dbHelper.removeFavorite(widget.movie.id);
    } else {
      // If the movie is not a favorite, add it to the database
      String posterUrl = widget.movie.posterPath.isNotEmpty
          ? 'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}'
          : '';

      // Extract the release year from the release date
      String releaseYear = 'Unknown';
      if (widget.movie.releaseDate.isNotEmpty) {
        final parsedDate = DateTime.tryParse(widget.movie.releaseDate);
        if (parsedDate != null) {
          releaseYear = parsedDate.year.toString();
        }
      }

      // Add the movie to favorites in the database
      await _dbHelper.addFavorite(
        itemId: widget.movie.id,
        title: widget.movie.title,
        posterPath: posterUrl,
        type: 'movie', // Specify the type as 'movie'
        year: releaseYear,
      );
    }

    // Update the favorite status 
    setState(() {
      _isFavorite = !_isFavorite;
    });

    // Show a snackbar message confirming the action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite
              ? '${widget.movie.title} added to favorites!'
              : '${widget.movie.title} removed from favorites!',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Display a loading indicator while fetching movie details
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary, // Set AppBar background color
          elevation: 0, // Remove shadow from AppBar
          title: Text(
            widget.movie.title, // Display movie title in AppBar
            style: const TextStyle(
              color: AppColors.accent,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true, // Center the title
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.text),
            onPressed: () => Navigator.of(context).pop(), // Navigate back on tap
          ),
        ),
        body: const Center(child: CircularProgressIndicator()), // Show loader
      );
    }

    // Display an error message if movie details failed to load
    if (_movieDetails == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: Text(
            widget.movie.title,
            style: const TextStyle(
              color: AppColors.accent,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.text),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const Center(
          child: Text(
            'Error loading movie details.',
            style: TextStyle(color: AppColors.text),
          ),
        ),
      );
    }

    // Display the movie details once fetched successfully
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary, // Set AppBar background color
        elevation: 0, // Remove shadow from AppBar
        title: Text(
          widget.movie.title, // Display movie title in AppBar
          style: const TextStyle(
            color: AppColors.accent,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Center the title
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Navigator.of(context).pop(), // Navigate back on tap
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: SingleChildScrollView( // Allows scrolling if content overflows
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start
            children: [
              // Movie Poster
              _movieDetails!.posterPath.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8), // Add rounded corners
                      child: AspectRatio(
                        aspectRatio: 2 / 3, // Define the image's aspect ratio (adjust as needed)
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${_movieDetails!.posterPath}', // Full URL of the poster image
                          fit: BoxFit.cover, // Cover the available space while maintaining aspect ratio
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 200, color: Colors.grey), // Show broken image icon on error
                        ),
                      ),
                    )
                  : Container(
                      height: 300, // Adjusted height for the placeholder
                      decoration: BoxDecoration(
                        color: Colors.grey, // Placeholder background color
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                      ),
                      child: const Center(
                        child: Text(
                          'Image Not Available', // Placeholder text
                          style: TextStyle(color: AppColors.text),
                        ),
                      ),
                    ),
              const SizedBox(height: 16), // Spacing between the image and title

              // Movie Title
              Text(
                _movieDetails!.title, // Display movie title
                style: const TextStyle(
                  fontSize: 32, // Font size
                  fontWeight: FontWeight.bold, // Bold text
                  color: AppColors.text, // Text color
                ),
              ),
              const SizedBox(height: 16), // Spacing between title and release year

              // Release Year
              Text(
                'Release year: ${_movieDetails!.releaseDate.isNotEmpty ? DateTime.parse(_movieDetails!.releaseDate).year : 'Unknown'}', // Display release year
                style: const TextStyle(
                  fontSize: 16, // Font size
                  fontWeight: FontWeight.w600, // Semi-bold text
                  color: AppColors.text, // Text color
                ),
              ),
              const SizedBox(height: 8), // Spacing between release year and popularity

              // Popularity
              Text(
                'Popularity: ${_movieDetails!.popularity.toStringAsFixed(1)}', // Display popularity
                style: const TextStyle(
                  fontSize: 16, // Font size
                  color: AppColors.text, // Text color
                ),
              ),
              const SizedBox(height: 16), // Spacing between popularity and overview

              // Movie Overview
              Text(
                _movieDetails!.overview.isNotEmpty
                    ? _movieDetails!.overview // Display overview if available
                    : 'No overview available.', // Default message if overview is missing
                style: const TextStyle(
                  fontSize: 16, // Font size
                  color: AppColors.text, // Text color
                ),
              ),
              const SizedBox(height: 32), // Spacing before the favorite button

              // Favorite Button
              Center(
                child: GestureDetector(
                  onTap: _toggleFavorite, // Handle tap events
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 24.0), // Padding inside the button
                    decoration: BoxDecoration(
                      color: Colors.yellow, // Button background color
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Wrap content vertically
                      children: [
                        Icon(
                          _isFavorite
                              ? Icons.thumb_up // Filled icon if favorite
                              : Icons.thumb_up_outlined, // Outlined icon if not favorite
                          color: Colors.black, // Icon color
                          size: 40, // Icon size
                        ),
                        const SizedBox(height: 8), // Spacing between icon and text
                        const Text(
                          'Favorite', // Button text
                          style: TextStyle(
                            color: Colors.black, // Text color
                            fontSize: 18, // Font size
                            fontWeight: FontWeight.bold, // Bold text
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32), // Spacing at the bottom
            ],
          ),
        ),
      ),
    );
  }
}