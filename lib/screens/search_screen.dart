import 'package:flutter/material.dart';
import 'package:popcornmate_app/widgets/section_title.dart';
import 'package:popcornmate_app/theme/colors.dart';

/*
  TODO: Implement search logic
  * I think that having everything in separate files is better but I'm not sure of how to do it easily.
*/

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
        body: Column(
          children: [
            const SectionTitle(title: 'What are you looking for?'),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Actors, movies, genres, directors...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
              ),
            )
          ],
        ));
  }
}