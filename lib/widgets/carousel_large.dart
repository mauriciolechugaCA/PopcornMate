import 'package:flutter/material.dart';
import 'package:popcornmate_app/theme/colors.dart';
import 'package:popcornmate_app/widgets/carousel.dart';

// This class is used to create a large carousel
class CarouselLarge extends Carousel {
  const CarouselLarge({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // Set a larger height for the large carousel
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 200, // Set a larger width for each item
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.accent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent, // This is the background color
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, // Aligns content to bottom
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Movie ${index + 1}',
                    style: const TextStyle(
                      color: AppColors.highlight,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}