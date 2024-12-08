import 'package:flutter/material.dart';
import 'package:popcornmate_app/api/api.dart';
import 'package:popcornmate_app/models/resulttrendingmovies.dart';
import 'package:popcornmate_app/models/movietoprated.dart';
import 'package:popcornmate_app/models/movieupcoming.dart';
import 'package:popcornmate_app/widgets/carousel_movies.dart'; 
import 'package:popcornmate_app/widgets/section_title.dart';
import 'package:popcornmate_app/theme/colors.dart';
import 'package:popcornmate_app/screens/movie_details_screen.dart';

// Made by Matheus Santos

class MoviesScreen extends StatefulWidget {
  final String title; // Title displayed in the AppBar

  const MoviesScreen({super.key, required this.title});

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  // Lists to store movies for each category
  List<ResultTrendingMovies> _trendingMovies = [];
  List<ResultTrendingMovies> _topRatedMovies = [];
  List<ResultTrendingMovies> _upcomingMovies = [];

  // Loading flags for each category to manage loading states
  bool _isLoadingTrending = true;
  bool _isLoadingTopRated = true;
  bool _isLoadingUpcoming = true;

  @override
  void initState() {
    super.initState();
    // Fetch movies for each category when the widget initializes
    _fetchTrendingMovies();
    _fetchTopRatedMovies();
    _fetchUpcomingMovies();
  }

  /// Fetches Trending Movies from the API and updates the state.
  Future<void> _fetchTrendingMovies() async {
    try {
      Api api = Api(); // Instantiate the API helper class
      List<ResultTrendingMovies> trending = await api.getTrendingMovies(); // Fetch trending movies
      setState(() {
        _trendingMovies = trending; // Update the trending movies list
        _isLoadingTrending = false; // Set loading flag to false
      });
    } catch (e) {
      print('Error fetching trending movies: $e'); // Log the error
      setState(() {
        _isLoadingTrending = false; // Set loading flag to false even if there's an error
      });
    }
  }

  /// Fetches Top-rated Movies from the API, maps them to ResultTrendingMovies, and updates the state.
  Future<void> _fetchTopRatedMovies() async {
    try {
      Api api = Api(); // Instantiate the API helper class
      List<ResultMovieTopRated> topRated = await api.getTopRatedMovies(); // Fetch top-rated movies

      // Map ResultMovieTopRated objects to ResultTrendingMovies for compatibility
      List<ResultTrendingMovies> mappedTopRated = topRated.map((movie) {
        return ResultTrendingMovies(
          adult: movie.adult,
          backdropPath: movie.backdropPath,
          genreIds: movie.genreIds,
          id: movie.id,
          originalLanguage: movie.originalLanguage,
          originalTitle: movie.originalTitle,
          overview: movie.overview,
          popularity: movie.popularity,
          posterPath: movie.posterPath,
          releaseDate: movie.releaseDate,
          title: movie.title,
          video: movie.video,
          voteAverage: movie.voteAverage,
          voteCount: movie.voteCount,
        );
      }).toList();

      setState(() {
        _topRatedMovies = mappedTopRated; // Update the top-rated movies list
        _isLoadingTopRated = false; // Set loading flag to false
      });
    } catch (e) {
      print('Error fetching top-rated movies: $e'); // Log the error
      setState(() {
        _isLoadingTopRated = false; // Set loading flag to false even if there's an error
      });
    }
  }

  /// Fetches Upcoming Movies from the API, maps them to ResultTrendingMovies, and updates the state.
  Future<void> _fetchUpcomingMovies() async {
    try {
      Api api = Api(); // Instantiate the API helper class
      List<ResultMovieUpcoming> upcoming = await api.getUpcomingMovies(); // Fetch upcoming movies

      // Map ResultMovieUpcoming objects to ResultTrendingMovies for compatibility
      List<ResultTrendingMovies> mappedUpcoming = upcoming.map((movie) {
        return ResultTrendingMovies(
          adult: movie.adult,
          backdropPath: movie.backdropPath,
          genreIds: movie.genreIds,
          id: movie.id,
          originalLanguage: movie.originalLanguage,
          originalTitle: movie.originalTitle,
          overview: movie.overview,
          popularity: movie.popularity,
          posterPath: movie.posterPath,
          releaseDate: movie.releaseDate,
          title: movie.title,
          video: movie.video,
          voteAverage: movie.voteAverage,
          voteCount: movie.voteCount,
        );
      }).toList();

      setState(() {
        _upcomingMovies = mappedUpcoming; // Update the upcoming movies list
        _isLoadingUpcoming = false; // Set loading flag to false
      });
    } catch (e) {
      print('Error fetching upcoming movies: $e'); // Log the error
      setState(() {
        _isLoadingUpcoming = false; // Set loading flag to false even if there's an error
      });
    }
  }

  /// Navigates to the MovieDetailsScreen with the selected movie.
  void _navigateToMovieDetails(BuildContext context, ResultTrendingMovies movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(movie: movie), // Pass the movie object
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Define a consistent height for all carousels
    const double carouselHeight = 250;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary, // Set the background color of the AppBar
        foregroundColor: AppColors.text, // Set the text and icon color
        elevation: 0, // Remove the shadow from the AppBar
        title: Text(
          widget.title, // Display the title passed to the screen
          style: const TextStyle(
            color: AppColors.accent,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Center the title in the AppBar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Popular Movies Section
            const SectionTitle(title: 'Popular'),
            SizedBox(
              height: carouselHeight, // Set a consistent height for the carousel
              child: _isLoadingTrending
                  ? const Center(child: CircularProgressIndicator()) // Show loader while fetching
                  : _trendingMovies.isEmpty
                      ? const Center(child: Text('No popular movies found')) // Show message if no movies
                      : CarouselMovies(
                          movies: _trendingMovies, // Pass the trending movies list
                          onTap: _navigateToMovieDetails, // Pass the navigation callback
                        ),
            ),

            // Top-rated Movies Section
            const SectionTitle(title: 'Top-rated'),
            SizedBox(
              height: carouselHeight, // Set a consistent height for the carousel
              child: _isLoadingTopRated
                  ? const Center(child: CircularProgressIndicator()) // Show loader while fetching
                  : _topRatedMovies.isEmpty
                      ? const Center(child: Text('No top-rated movies found')) // Show message if no movies
                      : CarouselMovies(
                          movies: _topRatedMovies, // Pass the top-rated movies list
                          onTap: _navigateToMovieDetails, // Pass the navigation callback
                        ),
            ),

            // New Releases Movies Section
            const SectionTitle(title: 'New Releases'),
            SizedBox(
              height: carouselHeight, // Set a consistent height for the carousel
              child: _isLoadingUpcoming
                  ? const Center(child: CircularProgressIndicator()) // Show loader while fetching
                  : _upcomingMovies.isEmpty
                      ? const Center(child: Text('No movies found')) // Show message if no movies
                      : CarouselMovies(
                          movies: _upcomingMovies, // Pass the upcoming movies list
                          onTap: _navigateToMovieDetails, // Pass the navigation callback
                        ),
            ),
          ],
        ),
      ),
    );
  }
}