class Movie {
  final int id;
  final String title;
  final String imageUrl;
  final String releaseDate;
  final String overview;
  final double popularity;
  final String duration;

  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.releaseDate,
    required this.overview,
    required this.popularity,
    required this.duration,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? '',
      imageUrl: 'https://image.tmdb.org/t/p/w500${json['poster_path'] ?? ''}',
      releaseDate: json['release_date'] ?? 'Unknown',
      overview: json['overview'] ?? 'No overview available.',
      popularity: json['popularity']?.toDouble() ?? 0.0,
      duration: '${json['runtime'] ?? 0} min',
    );
  }
}
