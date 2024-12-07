import 'package:flutter/material.dart';
import 'package:popcornmate_app/models/resulttrendingmovies.dart';
import 'package:popcornmate_app/theme/colors.dart';

class CarouselMovies extends StatelessWidget {
  final List<ResultTrendingMovies> movies; // List of movies to display
  final void Function(BuildContext, ResultTrendingMovies) onTap; // Callback for tap events

  const CarouselMovies({
    Key? key,
    required this.movies,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define consistent dimensions for all movie cards
    const double cardWidth = 150;

    return ListView.builder(
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      itemCount: movies.length, // Number of items in the carousel
      itemBuilder: (context, index) {
        final movie = movies[index]; // Current movie

        // Construct the full image URL or use a placeholder if unavailable
        String imageUrl = movie.posterPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
            : 'https://via.placeholder.com/150';

        // Extract the release year from the release date
        String releaseYear = movie.releaseDate.isNotEmpty
            ? '${DateTime.parse(movie.releaseDate).year}'
            : 'Unknown';

        return GestureDetector(
          onTap: () => onTap(context, movie), // Handle tap events
          child: Container(
            width: cardWidth, // Fixed width for each movie card
            margin: const EdgeInsets.symmetric(horizontal: 10), // Margin between cards
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.accent, // Border color
                width: 2, // Border width
              ),
              borderRadius: BorderRadius.circular(10), // Rounded corners
              color: Colors.transparent, // Transparent background
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start
              children: [
                // Movie Poster
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ), // Rounded corners only at the top
                    child: Image.network(
                      imageUrl, // URL of the movie poster
                      fit: BoxFit.cover, // Cover the entire container
                      width: cardWidth, // Ensure the width matches the card
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 50, color: Colors.grey), // Show broken image icon on error
                    ),
                  ),
                ),
                // Movie Title and Release Year
                Padding(
                  padding: const EdgeInsets.all(8.0), // Padding around the text
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                    children: [
                      Text(
                        movie.title, // Display the movie title
                        style: const TextStyle(
                          color: AppColors.highlight, // Text color
                          fontSize: 14, // Font size
                          fontWeight: FontWeight.bold, // Bold text
                        ),
                        overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                        maxLines: 1, // Limit to one line
                      ),
                      const SizedBox(height: 4), // Spacing between title and year
                      Text(
                        'Release year: $releaseYear', // Display the release year
                        style: const TextStyle(
                          color: AppColors.text, // Text color
                          fontSize: 12, // Font size
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}