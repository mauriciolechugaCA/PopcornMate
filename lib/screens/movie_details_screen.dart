import 'package:flutter/material.dart';
import 'package:popcornmate_app/theme/colors.dart';
import 'package:popcornmate_app/models/resulttrendingmovies.dart';
import 'package:intl/intl.dart';

// Defines the movie details screen as a stateful widget (dynamic state management).
class MovieDetailsScreen extends StatefulWidget {
  final ResultTrendingMovies movie; // The movie to be displayed

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool _isFavorite = false; // Tracks whether the movie is marked as a favorite

  // Toggles between adding/removing the movie from favorites.
  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite ? '${widget.movie.title} added to favorites!' : '${widget.movie.title} removed from favorites!',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

@override
  Widget build(BuildContext context) {
    // Movie poster image URL
    String imageUrl = widget.movie.posterPath.isNotEmpty
        ? 'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}'
        : 'https://via.placeholder.com/150';

    // Formats the movie's release date
    String releaseDate = widget.movie.releaseDate != null
        ? DateFormat('yyyy-MM-dd').format(widget.movie.releaseDate!)
        : 'Unknown';

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
          onPressed: () {
            Navigator.of(context).pop(); // Returns to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // To prevent overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Displays the movie's poster or a placeholder
              imageUrl.isNotEmpty
                  ? Image.network(imageUrl)
                  : Container(
                      height: 200,
                      color: Colors.grey,
                      child: const Center(
                        child: Text(
                          'No Image Available',
                          style: TextStyle(color: AppColors.text),
                        ),
                      ),
                    ),
              const SizedBox(height: 16),
              // Movie title
              Text(
                widget.movie.title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 16),
              // Release date
              Text(
                'Release Date: $releaseDate',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 8),
              // Movie popularity
              Text(
                'Popularity: ${widget.movie.popularity.toStringAsFixed(1)}',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 16),
              // Movie overview
              Text(
                widget.movie.overview.isNotEmpty ? widget.movie.overview : 'No overview available.',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 32),
              // Button to toggle favorite status
              Center(
                child: GestureDetector(
                  onTap: _toggleFavorite,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isFavorite ? Icons.thumb_up : Icons.thumb_up_outlined,
                          color: Colors.black,
                          size: 40,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Favorite',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
