import 'package:flutter/material.dart';
import 'package:popcornmate_app/theme/colors.dart';
import 'package:popcornmate_app/models/resulttrendingmovies.dart';

class CarouselLarge extends StatelessWidget {
  final List<dynamic> items;

  const CarouselLarge({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          width: 200,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.accent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
            color: Colors.transparent,
          ),
          child: ClipRRect(
            // ClipRRect is used to clip the image to a rounded rectangle. ChatGPT helped me with this. ^ML
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                if (item.posterPath.isNotEmpty)
                  Positioned.fill(
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${item.posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.9),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      item is ResultTrendingMovies ? item.title : item.name,
                      style: const TextStyle(
                        color: AppColors.highlight,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
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
