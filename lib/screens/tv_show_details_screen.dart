import 'package:flutter/material.dart';

// This class is used to display the details of a TV show
class TvShowDetailsScreen extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String year;

  // Constructor
  const TvShowDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.year,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TvShowDetailsScreenState createState() => _TvShowDetailsScreenState();
}

class _TvShowDetailsScreenState extends State<TvShowDetailsScreen> {
  // To track whether the thumbs-up button has been pressed
  bool isLiked = false;

  // Method to toggle the liked status
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row to display title and thumbs-up icon on the same line
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10), // Adds space between title and icon
                      IconButton(
                        icon: Icon(
                          Icons.thumb_up,
                          color: isLiked ? const Color(0xFFFFAC41) : Colors.white, // Change color when liked
                        ),
                        onPressed: toggleLike,
                        iconSize: 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Year: ${widget.year}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.description.isNotEmpty
                        ? widget.description
                        : 'No description available.',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}