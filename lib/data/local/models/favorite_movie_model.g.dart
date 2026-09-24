// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_movie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteMovieModelAdapter extends TypeAdapter<FavoriteMovieModel> {
  @override
  final int typeId = 0;

  @override
  FavoriteMovieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteMovieModel(
      id: fields[0] as int,
      title: fields[1] as String,
      posterPath: fields[2] as String?,
      backdropPath: fields[3] as String?,
      overview: fields[4] as String,
      releaseDate: fields[5] as String,
      voteAverage: fields[6] as double,
      voteCount: fields[7] as int,
      runtime: fields[8] as int,
      adult: fields[9] as bool,
      tagline: fields[10] as String,
      originalTitle: fields[11] as String,
      originalLanguage: fields[12] as String,
      status: fields[13] as String,
      genres: (fields[14] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteMovieModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.posterPath)
      ..writeByte(3)
      ..write(obj.backdropPath)
      ..writeByte(4)
      ..write(obj.overview)
      ..writeByte(5)
      ..write(obj.releaseDate)
      ..writeByte(6)
      ..write(obj.voteAverage)
      ..writeByte(7)
      ..write(obj.voteCount)
      ..writeByte(8)
      ..write(obj.runtime)
      ..writeByte(9)
      ..write(obj.adult)
      ..writeByte(10)
      ..write(obj.tagline)
      ..writeByte(11)
      ..write(obj.originalTitle)
      ..writeByte(12)
      ..write(obj.originalLanguage)
      ..writeByte(13)
      ..write(obj.status)
      ..writeByte(14)
      ..write(obj.genres);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteMovieModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
