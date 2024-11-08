import 'package:flutter/material.dart';
import 'package:popcornmate_app/widgets/carousel.dart';
import 'package:popcornmate_app/widgets/section_title.dart';

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
