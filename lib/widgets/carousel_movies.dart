import 'package:flutter/material.dart';
import 'package:popcornmate_app/models/movie.dart';
import 'package:popcornmate_app/theme/colors.dart';

class CarouselMovies extends StatelessWidget {
  final List<Movie> movies;
  final void Function(BuildContext, int) onTap;

  const CarouselMovies({
    super.key,
    required this.movies,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return GestureDetector(
          onTap: () => onTap(context, index),
          child: Container(
            width: 150,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.accent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: movie.imageUrl.isNotEmpty
                      ? Image.network(
                          movie.imageUrl,
                          fit: BoxFit.cover,
                        )
                      : const Placeholder(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: AppColors.highlight,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Duration: ${movie.duration}', 
                        style: const TextStyle(
                          color: AppColors.text,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Released: ${movie.releaseDate}',
                        style: const TextStyle(
                          color: AppColors.text,
                          fontSize: 14,
                        ),
                      ),
                    ],
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
