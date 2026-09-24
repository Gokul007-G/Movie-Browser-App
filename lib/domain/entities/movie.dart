class Movie {
  final int id;
  final bool adult;
  final String? backdropPath;
  final String title;
  final String originalTitle;
  final String overview;
  final String? posterPath;
  final String mediaType;
  final String originalLanguage;
  final List<int> genreIds;
  final double popularity;
  final String releaseDate;
  final bool softcore;
  final bool video;
  final double voteAverage;
  final int voteCount;

  const Movie({
    required this.adult,
    this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    this.posterPath,
    required this.mediaType,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.softcore,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
}
