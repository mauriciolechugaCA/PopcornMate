
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



class ResultTrendingMovies 
{
  ResultTrendingMovies
  (
    {
      required this.adult,
      required this.backdropPath,
      required this.genreIds,
      required this.id,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.voteCount,
    }
  );

  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  factory ResultTrendingMovies.fromJson(Map<String, dynamic> json) {
    return ResultTrendingMovies(
      adult: json["adult"] ?? false,
      backdropPath: json["backdrop_path"] ?? "",
      genreIds: json["genre_ids"] == null
          ? []
          : List<int>.from(json["genre_ids"]!.map((x) => x)),
      id: json["id"] ?? 0,
      originalLanguage: json["original_language"] ?? "",
      originalTitle: json["original_title"] ?? "",
      overview: json["overview"] ?? "",
      popularity: json["popularity"] ?? 0.0,
      posterPath: json["poster_path"] ?? "",
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      title: json["title"] ?? "",
      video: json["video"] ?? false,
      voteAverage: json["vote_average"] ?? 0.0,
      voteCount: json["vote_count"] ?? 0,
    );
  }
}