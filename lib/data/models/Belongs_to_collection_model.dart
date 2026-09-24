import 'package:moviebrowserapp/domain/entities/movie_details.dart';

class BelongsToCollectionModel extends BelongsToCollection {
  const BelongsToCollectionModel({
    required super.id,
    required super.name,
    super.posterPath,
    super.backdropPath,
  });

  factory BelongsToCollectionModel.fromJson(Map<String, dynamic> json) {
    return BelongsToCollectionModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
    };
  }
}