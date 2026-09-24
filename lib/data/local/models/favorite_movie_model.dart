import 'package:hive/hive.dart';

part 'favorite_movie_model.g.dart';

@HiveType(typeId: 0)
class FavoriteMovieModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? posterPath;

  @HiveField(3)
  final String? backdropPath;

  @HiveField(4)
  final String overview;

  @HiveField(5)
  final String releaseDate;

  @HiveField(6)
  final double voteAverage;

  @HiveField(7)
  final int voteCount;

  @HiveField(8)
  final int runtime;

  @HiveField(9)
  final bool adult;

  @HiveField(10)
  final String tagline;

  @HiveField(11)
  final String originalTitle;

  @HiveField(12)
  final String originalLanguage;

  @HiveField(13)
  final String status;

  @HiveField(14)
  final List<String> genres;

   FavoriteMovieModel({
    required this.id,
    required this.title,
    this.posterPath,
    this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.runtime,
    required this.adult,
    required this.tagline,
    required this.originalTitle,
    required this.originalLanguage,
    required this.status,
    required this.genres,
  });
}