import 'resulttrendingmovies.dart';


//Auto generated using https://dart-quicktype.netlify.app/
class MovieApi {
  MovieApi({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<ResultTrendingMovies> results;
  final int totalPages;
  final int totalResults;

  factory MovieApi.fromJson(Map<String, dynamic> json) {
    return MovieApi(
      page: json["page"] ?? 0,
      results: json["results"] == null
          ? []
          : List<ResultTrendingMovies>.from(
              json["results"]!.map((x) => ResultTrendingMovies.fromJson(x))),
      totalPages: json["total_pages"] ?? 0,
      totalResults: json["total_results"] ?? 0,
    );
  }
}

