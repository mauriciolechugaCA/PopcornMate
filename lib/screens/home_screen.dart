import 'package:flutter/material.dart';
import 'package:popcornmate_app/widgets/carousel.dart';
import 'package:popcornmate_app/widgets/section_title.dart';
import 'package:popcornmate_app/theme/colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.text,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: AppColors.accent,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SectionTitle(title: 'Featured Movies'),
            SizedBox(height: 200, child: Carousel()),
            SectionTitle(title: 'Upcoming Releases'),
            SizedBox(height: 200, child: Carousel()),
            SectionTitle(title: 'Top-rated Movies'),
            SizedBox(height: 200, child: Carousel()),
          ],
        ),
      ),
    );
  }
}
