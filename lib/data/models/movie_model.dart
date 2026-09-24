import 'package:moviebrowserapp/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.adult,
    super.backdropPath,
    required super.id,
    required super.title,
    required super.originalTitle,
    required super.overview,
    super.posterPath,
    required super.mediaType,
    required super.originalLanguage,
    required super.genreIds,
    required super.popularity,
    required super.releaseDate,
    required super.softcore,
    required super.video,
    required super.voteAverage,
    required super.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'],
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'],
      mediaType: json['media_type'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      popularity: (json['popularity'] ?? 0).toDouble(),
      releaseDate: json['release_date'] ?? '',
      softcore: json['softcore'] ?? false,
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'media_type': mediaType,
      'original_language': originalLanguage,
      'genre_ids': genreIds,
      'popularity': popularity,
      'release_date': releaseDate,
      'softcore': softcore,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
