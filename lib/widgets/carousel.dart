import 'package:flutter/material.dart';

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
          color: Colors.deepPurpleAccent,
          child: Center(
            child: Text(
              'Movie ${index + 1}',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        );
      },
    );
  }
}
