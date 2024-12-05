import 'package:flutter/material.dart';
import 'package:popcornmate_app/models/resulttrendingmovies.dart';
import 'package:popcornmate_app/theme/colors.dart';

class CarouselMovies extends StatelessWidget {
  final List<ResultTrendingMovies> movies; // List of movies to display in the carousel
  final void Function(BuildContext, int) onTap; // Callback function for movie taps

  const CarouselMovies({
    super.key,
    required this.movies,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal, // Makes the list scroll horizontally
      itemCount: movies.length, // Number of movies to display
      itemBuilder: (context, index) {
        final movie = movies[index]; // Current movie in the list
        String imageUrl = movie.posterPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}' // Full URL for the movie poster
            : 'https://via.placeholder.com/150'; // Placeholder if no poster is available

        String releaseDate = movie.releaseDate != null
            ? '${DateTime.parse(movie.releaseDate!).year}' // Extracts the year from the release date
            : 'Unknown'; // Default value for missing release dates

        return GestureDetector(
          onTap: () => onTap(context, index), // Calls the provided callback when tapped
          child: Container(
            width: 150, // Fixed width for each movie card
            margin: const EdgeInsets.symmetric(horizontal: 10), // Adds spacing between cards
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.accent, // Highlight color for the border
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10), // Rounded corners
              color: Colors.transparent, // Transparent background
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, // Aligns content to the bottom
              children: [
                // Displays the movie poster or a placeholder
                Expanded(
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover, // Ensures the image covers the entire area
                        )
                      : const Placeholder(), // Placeholder widget for missing images
                ),
                // Displays movie title and release date
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title, // Displays the movie title
                        style: const TextStyle(
                          color: AppColors.highlight, // Highlighted text color
                          fontSize: 20, // Font size for the title
                          fontWeight: FontWeight.bold, // Bold font
                        ),
                      ),
                      const SizedBox(height: 4), // Adds spacing between text elements
                      Text(
                        'Release year: $releaseDate', // Displays the release date
                        style: const TextStyle(
                          color: AppColors.text, // Standard text color
                          fontSize: 14, // Smaller font size for release date
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
