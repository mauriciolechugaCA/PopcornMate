import 'package:flutter/material.dart';
import 'package:popcornmate_app/theme/colors.dart';
import 'package:popcornmate_app/screens/tv_show_details_screen.dart';

// This class is used to display the TV show screen
class TvScreen extends StatelessWidget {
  const TvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data representing TV show categories
    final Map<String, List<Map<String, String>>> tvShowCategories = {
      // List of popular TV shows
      'Popular': [
        {'title': 'The Witcher', 'image': 'assets/witcher.jpg', 'year': '2019', 'genre': 'Fantasy'},
        {'title': 'The Office', 'image': 'assets/office.jpg', 'year': '2005', 'genre': 'Comedy'},
        {'title': 'The Boys', 'image': 'assets/boys.jpg', 'year': '2019', 'genre': 'Action'},
        {'title': 'Friends', 'image': 'assets/friends.jpg', 'year': '1994', 'genre': 'Comedy'},
        {'title': 'Better Call Saul', 'image': 'assets/better_call_saul.jpg', 'year': '2015', 'genre': 'Crime'},
      ],
      // List of top-rated TV shows
      'Top Rated': [
        {'title': 'Chernobyl', 'image': 'assets/chernobyl.jpg', 'year': '2019', 'genre': 'Drama'},
        {'title': 'The Sopranos', 'image': 'assets/sopranos.jpg', 'year': '1999', 'genre': 'Crime'},
        {'title': 'Band of Brothers', 'image': 'assets/band_of_brothers.jpg', 'year': '2001', 'genre': 'War'},
        {'title': 'Sherlock', 'image': 'assets/sherlock.jpg', 'year': '2010', 'genre': 'Mystery'},
        {'title': 'Planet Earth', 'image': 'assets/planet_earth.jpg', 'year': '2006', 'genre': 'Documentary'},
      ],
      // List of upcoming TV shows
      'Upcoming': [
        {'title': 'Loki', 'image': 'assets/loki.jpg', 'year': '2023', 'genre': 'Sci-Fi'},
        {'title': 'Foundation', 'image': 'assets/foundation.jpg', 'year': '2023', 'genre': 'Sci-Fi'},
        {'title': 'The Crown', 'image': 'assets/crown.jpg', 'year': '2023', 'genre': 'Drama'},
        {'title': 'Andor', 'image': 'assets/andor.jpg', 'year': '2023', 'genre': 'Adventure'},
        {'title': 'Wheel of Time', 'image': 'assets/wheel_of_time.jpg', 'year': '2023', 'genre': 'Fantasy'},
      ],
    };

    // Build the user interface for the TV Shows screen
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TV Shows', // Static title for the screen
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        centerTitle: true, // Centers the title horizontally
        backgroundColor: AppColors.primary,
      ),

      // Display the TV show categories and carousels
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // padding for the screen
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tvShowCategories.entries.map((entry) {
              final categoryTitle = entry.key; // Category title (e.g., 'Popular')
              final shows = entry.value; // List of shows for the category

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display category title
                  Text(
                    categoryTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 10), // Space between title and carousel
                  SizedBox(
                    height: 250, // Height of the carousel
                    child: _buildCarousel(context, shows), // Display carousel
                  ),
                  const SizedBox(height: 20), // Space between categories
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // Builds the horizontal carousel for a category
  Widget _buildCarousel(BuildContext context, List<Map<String, String>> tvShows) {
    return ListView.builder(
      scrollDirection: Axis.horizontal, // Enables horizontal scrolling
      itemCount: tvShows.length, // Number of shows in the carousel
      itemBuilder: (context, index) {
        final show = tvShows[index]; // Current TV show data
        return GestureDetector(
          onTap: () {
            // Navigate to the details screen when an item is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TvShowDetailsScreen(
                  title: show['title']!,
                  image: show['image']!,
                  genre: show['genre']!,
                  year: show['year']!,
                  description: 'Description for ${show['title']}', // Placeholder description
                ),
              ),
            );
          },

          // Display each item in the carousel
          child: Container(
            width: 150, // Width of each carousel item
            margin: const EdgeInsets.symmetric(horizontal: 10), // Spacing between items
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              border: Border.all(color: AppColors.accent, width: 2), // Border styling
            ),
            child: Column(
              children: [
                // Display show image
                Expanded(
                  // Expand the image to fill the available space
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Rounded corners for the image
                    child: Image.asset(show['image']!, fit: BoxFit.cover),
                  ),
                ),
                // Display show title
                Padding(
                  padding: const EdgeInsets.all(8.0), // Padding for the title
                  child: Text(
                    show['title']!,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Display show genre and year
                Text(
                  '${show['genre']} - ${show['year']}',
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 12,
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