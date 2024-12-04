import 'package:flutter/material.dart';
import 'package:popcornmate_app/api/apidetails.dart';
import 'package:popcornmate_app/theme/colors.dart';
import 'package:popcornmate_app/models/resulttrendingtvshows.dart';
import 'package:popcornmate_app/models/resulttrendingmovies.dart';

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
        
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.accent, width: 2),
            borderRadius: BorderRadius.circular(8),
            //color: Colors.white,
            color: AppColors.secondary,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Poster img
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  '${ApiDetails.imgPath}${result.posterPath}',
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              //Title, Release Date and Rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Title. Needs to check if is Movie or TV
                    Text(
                      isMoviesSelected ? result.title : result.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        // color: Colors.black,
                        color: AppColors.highlight,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    //Release Date or First Air Date
                    Text(
                      isMoviesSelected
                          ? 'Release Date: ${result.releaseDate?.toLocal().toString().split(' ')[0] ?? 'N/A'}'
                          : 'First Air Date: ${result.firstAirDate?.toLocal().toString().split(' ')[0] ?? 'N/A'}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    //Rating and Vote Count
                    Text(
                      'Rating: ${result.voteAverage} (${result.voteCount} votes)',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
