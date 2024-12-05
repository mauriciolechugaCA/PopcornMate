import 'package:flutter/material.dart';
import 'package:popcornmate_app/api/apidetails.dart';
import 'package:popcornmate_app/theme/colors.dart';
//TV Details Screen
import 'package:popcornmate_app/screens/tv_show_details_screen.dart';


class SearchResultList extends StatelessWidget {
  final List<dynamic> results;
  final bool isMoviesSelected;

  const SearchResultList({super.key, required this.results, required this.isMoviesSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];

        return GestureDetector(
          onTap: () {
            //TvShowDetailsScreen or MovieDetailsScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TvShowDetailsScreen(
                  title: isMoviesSelected ? result.title : result.name,
                  description: result.overview ?? 'No description available.',
                  imageUrl: '${ApiDetails.imgPath}${result.posterPath}',
                  year: isMoviesSelected
                      ? (result.releaseDate?.split('-')[0] ?? 'Unknown')
                      : (result.firstAirDate?.split('-')[0] ?? 'Unknown'),
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.accent, width: 2),
              borderRadius: BorderRadius.circular(8),
              color: AppColors.secondary,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poster img
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: result.posterPath.isNotEmpty
                      ? Image.network(
                          '${ApiDetails.imgPath}${result.posterPath}',
                          width: 100,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          Icons.no_photography,
                          size: 100,
                          color: Colors.grey,
                        ),
                ),
                const SizedBox(width: 16),
                // Title, Release Date and Rating
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        isMoviesSelected ? result.title : result.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.highlight,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      // Release Date or First Air Date
                      Text(
                        isMoviesSelected
                            ? 'Release Date: ${result.releaseDate ?? 'N/A'}'
                            : 'First Air Date: ${result.firstAirDate ?? 'N/A'}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 5),
                      // Rating and Vote Count
                      Text(
                        'Rating: ${result.voteAverage} (${result.voteCount} votes)',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
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
