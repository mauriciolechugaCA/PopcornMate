import 'package:flutter/material.dart';

// This class is used to create sections titles
class SectionTitle extends StatelessWidget {
  final String title;

  // Constructor to receive the title of the section {required}
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, top: 20.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ));
  }
}
