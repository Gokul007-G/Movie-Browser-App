import 'package:moviebrowserapp/data/models/Belongs_to_collection_model.dart';
import 'package:moviebrowserapp/data/models/genre_model.dart';
import 'package:moviebrowserapp/data/models/production_company_model.dart';
import 'package:moviebrowserapp/data/models/production_country_model.dart';
import 'package:moviebrowserapp/data/models/spoken_language_model.dart';
import 'package:moviebrowserapp/domain/entities/movie_details.dart';

class MovieDetailsModel extends MovieDetails {
  const MovieDetailsModel({
    required super.adult,
    super.backdropPath,
    super.belongsToCollection,
    required super.budget,
    required super.genres,
    required super.homepage,
    required super.id,
    required super.imdbId,
    required super.originCountry,
    required super.originalLanguage,
    required super.originalTitle,
    required super.overview,
    required super.popularity,
    super.posterPath,
    required super.productionCompanies,
    required super.productionCountries,
    required super.releaseDate,
    required super.revenue,
    required super.runtime,
    required super.softcore,
    required super.spokenLanguages,
    required super.status,
    required super.tagline,
    required super.title,
    required super.video,
    required super.voteAverage,
    required super.voteCount,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      adult: json['adult'] ?? false,

      backdropPath: json['backdrop_path'],

      belongsToCollection: json['belongs_to_collection'] != null
          ? BelongsToCollectionModel.fromJson(
              json['belongs_to_collection'],
            )
          : null,

      budget: json['budget'] ?? 0,

      genres: (json['genres'] as List<dynamic>? ?? [])
          .map((e) => GenreModel.fromJson(e))
          .toList(),

      homepage: json['homepage'] ?? '',

      id: json['id'] ?? 0,

      imdbId: json['imdb_id'] ?? '',

      originCountry: List<String>.from(
        json['origin_country'] ?? [],
      ),

      originalLanguage: json['original_language'] ?? '',

      originalTitle: json['original_title'] ?? '',

      overview: json['overview'] ?? '',

      popularity: (json['popularity'] ?? 0).toDouble(),

      posterPath: json['poster_path'],

      productionCompanies: (json['production_companies'] as List<dynamic>? ?? [])
          .map((e) => ProductionCompanyModel.fromJson(e))
          .toList(),

      productionCountries:
          (json['production_countries'] as List<dynamic>? ?? [])
              .map((e) => ProductionCountryModel.fromJson(e))
              .toList(),

      releaseDate: json['release_date'] ?? '',

      revenue: json['revenue'] ?? 0,

      runtime: json['runtime'] ?? 0,

      softcore: json['softcore'] ?? false,

      spokenLanguages: (json['spoken_languages'] as List<dynamic>? ?? [])
          .map((e) => SpokenLanguageModel.fromJson(e))
          .toList(),

      status: json['status'] ?? '',

      tagline: json['tagline'] ?? '',

      title: json['title'] ?? '',

      video: json['video'] ?? false,

      voteAverage: (json['vote_average'] ?? 0).toDouble(),

      voteCount: json['vote_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'belongs_to_collection':
          (belongsToCollection as BelongsToCollectionModel?)?.toJson(),
      'budget': budget,
      'genres': genres
          .map((e) => (e as GenreModel).toJson())
          .toList(),
      'homepage': homepage,
      'id': id,
      'imdb_id': imdbId,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'production_companies': productionCompanies
          .map((e) => (e as ProductionCompanyModel).toJson())
          .toList(),
      'production_countries': productionCountries
          .map((e) => (e as ProductionCountryModel).toJson())
          .toList(),
      'release_date': releaseDate,
      'revenue': revenue,
      'runtime': runtime,
      'softcore': softcore,
      'spoken_languages': spokenLanguages
          .map((e) => (e as SpokenLanguageModel).toJson())
          .toList(),
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}