import 'package:flutter/material.dart';
import 'package:popcornmate_app/theme/colors.dart';

// This class is used to display the details of a specific TV show
class TvShowDetailsScreen extends StatelessWidget {
  final String title;
  final String image;
  final String genre;
  final String year;
  final String description;

  // Constructor for the Details Screen
  const TvShowDetailsScreen({
    super.key,
    required this.title,
    required this.image,
    required this.genre,
    required this.year,
    required this.description,
  });

  // Constructs the visual layout for the Details Screen, including:
  // The AppBar with a title and back button
  // The main content displaying the TV show's image, title, genre, year, description, and a like button
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Fixed title for the Details Screen
        title: const Text(
          'TV Shows', 
          style: TextStyle(
            fontSize: 28, // Large font size of the title
            fontWeight: FontWeight.bold,// Makes the text bold on the title
            color: AppColors.accent,
          ),
        ),
        centerTitle: true, // Centers the title horizontally
        backgroundColor: AppColors.primary,
        leading: IconButton(
          // Back button to return to the previous screen
          icon: const Icon(Icons.arrow_back, color: AppColors.accent),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Outer padding for the screen
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns content to the left
            children: [
              // Cover image for the TV show
              Align(
                alignment: Alignment.center, // Centers the image horizontally
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8), // Rounds the edges of the image
                  child: Container(
                    // Adds padding and adjusts the size of the image
                    padding: const EdgeInsets.all(8),
                    width: 300, // Fixed width for the image
                    height: 300, // Fixed height for the image
                    child: Image.asset(
                      image, // Path to the image file
                      fit: BoxFit.cover, // Ensures the image covers the space without distortion
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16), // Space between the image and the title

              // Row containing the series name and a "like" button
              Row(
                crossAxisAlignment: CrossAxisAlignment.center, // Aligns elements vertically
                children: [
                  // Series name
                  Text(
                    title, 
                    style: const TextStyle(
                      fontSize: 28, // Large font size for the title
                      fontWeight: FontWeight.bold, // Makes the text bold
                      color: AppColors.text, // Text color
                    ),
                  ),
                  const SizedBox(width: 4), // Reduces the gap between the title and the like icon
                  IconButton(
                    icon: const Icon(Icons.thumb_up, color: AppColors.text, size: 28), // Like button icon
                    onPressed: () {
                      // TODO: Add logic to handle like action
                    },
                    padding: EdgeInsets.zero, // Removes default padding from the button
                    constraints: const BoxConstraints(), // Removes default size constraints from the button
                  ),
                ],
              ),
              const SizedBox(height: 8), // Space between the row and additional information

              // Additional information (genre and year)
              Text(
                '$genre - $year', 
                style: const TextStyle(
                  fontSize: 16, // Medium font size
                  color: Colors.grey, // Light gray color for additional information
                ),
              ),
              const SizedBox(height: 16), // Space before the description

              // Description section title
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 18, // Medium font size
                  fontWeight: FontWeight.bold, // Makes the text bold
                  color: AppColors.text, // Text color
                ),
              ),
              const SizedBox(height: 8), // Space before the description content

              // Description content with a fixed font size
              Text(
                description, 
                style: const TextStyle(
                  fontSize: 16, // Regular font size
                  color: AppColors.text, // Text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}