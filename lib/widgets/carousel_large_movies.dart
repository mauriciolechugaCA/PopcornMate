import 'package:flutter/material.dart';
import 'package:popcornmate_app/models/resulttrendingmovies.dart';
import 'package:popcornmate_app/theme/colors.dart';
import 'package:popcornmate_app/api/apidetails.dart'; 
import 'package:intl/intl.dart';

class CarouselLargeMovies extends StatelessWidget {
  final List<ResultTrendingMovies> movies; // List of movies to display
  final void Function(BuildContext, int) onTap; // Callback for movie taps

  const CarouselLargeMovies({
    super.key,
    required this.movies,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal, // Enables horizontal scrolling
      itemCount: movies.length, // Number of movies to display
      itemBuilder: (context, index) {
        final movie = movies[index]; // Current movie in the list
        String imageUrl = movie.posterPath.isNotEmpty
            ? '${ApiDetails.imgPath}${movie.posterPath}' // Constructs the full poster URL
            : 'https://via.placeholder.com/150'; // Placeholder for missing posters

        String releaseDate = movie.releaseDate != null
            ? DateFormat('yyyy-MM-dd').format(movie.releaseDate!) // Formats the release date
            : 'Unknown'; // Default value for missing release dates

        return GestureDetector(
          onTap: () => onTap(context, index), // Calls onTap callback
          child: Container(
            width: 200, // Larger width for movie cards
            margin: const EdgeInsets.symmetric(horizontal: 10), // Adds spacing between cards
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.accent, // Border color for highlighting
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
                          fit: BoxFit.cover, // Ensures the image covers the area proportionally
                        )
                      : const Placeholder(), // Placeholder for missing images
                ),
                // Displays movie title and release date with larger text
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title, // Displays the movie title
                        style: const TextStyle(
                          color: AppColors.highlight, // Highlighted text color
                          fontSize: 24, // Larger font size for titles
                          fontWeight: FontWeight.bold, // Bold font
                        ),
                      ),
                      const SizedBox(height: 4), // Adds spacing between elements
                      Text(
                        'Released: $releaseDate', // Displays the release date
                        style: const TextStyle(
                          color: AppColors.text, // Standard text color
                          fontSize: 16, // Slightly larger font size for the date
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
