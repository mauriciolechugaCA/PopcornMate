
//Auto generated using https://dart-quicktype.netlify.app/
class TvShow {
    TvShow({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    final int page;
    final List<ResultTrendingTvShows> results;
    final int totalPages;
    final int totalResults;

    factory TvShow.fromJson(Map<String, dynamic> json){ 
        return TvShow(
            page: json["page"] ?? 0,
            results: json["results"] == null ? [] : List<ResultTrendingTvShows>.from(json["results"]!.map((x) => ResultTrendingTvShows.fromJson(x))),
            totalPages: json["total_pages"] ?? 0,
            totalResults: json["total_results"] ?? 0,
        );
    }

}


class ResultTrendingTvShows {
    ResultTrendingTvShows({
        required this.backdropPath,
        required this.id,
        required this.name,
        required this.originalName,
        required this.overview,
        required this.posterPath,
        required this.mediaType,
        required this.adult,
        required this.originalLanguage,
        required this.genreIds,
        required this.popularity,
        required this.firstAirDate,
        required this.voteAverage,
        required this.voteCount,
        required this.originCountry,
    });

    final String backdropPath;
    final int id;
    final String name;
    final String originalName;
    final String overview;
    final String posterPath;
    final String mediaType;
    final bool adult;
    final String originalLanguage;
    final List<int> genreIds;
    final double popularity;
    final DateTime? firstAirDate;
    final double voteAverage;
    final int voteCount;
    final List<String> originCountry;

    factory ResultTrendingTvShows.fromJson(Map<String, dynamic> json){ 
        return ResultTrendingTvShows(
            backdropPath: json["backdrop_path"] ?? "",
            id: json["id"] ?? 0,
            name: json["name"] ?? "",
            originalName: json["original_name"] ?? "",
            overview: json["overview"] ?? "",
            posterPath: json["poster_path"] ?? "",
            mediaType: json["media_type"] ?? "",
            adult: json["adult"] ?? false,
            originalLanguage: json["original_language"] ?? "",
            genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
            popularity: json["popularity"] ?? 0.0,
            firstAirDate: DateTime.tryParse(json["first_air_date"] ?? ""),
            voteAverage: json["vote_average"] ?? 0.0,
            voteCount: json["vote_count"] ?? 0,
            originCountry: json["origin_country"] == null ? [] : List<String>.from(json["origin_country"]!.map((x) => x)),
        );
    }

}
