import 'package:flutter/material.dart';
import 'package:popcornmate_app/theme/colors.dart';

// This class is used to create a carousel
class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          width: 150,
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
            mainAxisAlignment:
                MainAxisAlignment.end, // Aligns content to bottom
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Movie ${index + 1}',
                  style: const TextStyle(
                    color: AppColors.highlight,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
