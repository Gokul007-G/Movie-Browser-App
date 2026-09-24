import 'package:dio/dio.dart';
import 'package:moviebrowserapp/core/config/env_config.dart';
import 'package:moviebrowserapp/core/constants/api_constants.dart';
import 'package:moviebrowserapp/core/errors/exceptions.dart';
import 'package:moviebrowserapp/core/errors/logger.dart';
import 'package:moviebrowserapp/data/models/movie_model.dart';
import 'package:moviebrowserapp/data/models/movie_details_model.dart';

class MovieRemoteDatasource {
  final Dio dio;

  MovieRemoteDatasource({required this.dio});

  //API to call the popular movie list
  Future<List<MovieModel>> getMovies({required int page}) async {
    Logger.i('$dio${ApiConstants.movies}');
    try {
      final response = await dio.get(
        ApiConstants.movies,
        queryParameters: {
          'api_key': EnvConfig.tmdbApiKey,
          'language': 'en-US',
          'page': page,
        },
      );

      final result = response.data['results'] as List;

      return result.map((json) => MovieModel.fromJson(json)).toList();
    } on DioException catch (e) {
      Logger.e(e);
      throw ServerException(e.message ?? 'Failed to Fetch Movies');
    }
  }

  //API to call the movie list
  Future<MovieDetailsModel> getMoviesDetails({required int movieId}) async {
    Logger.e('${ApiConstants.movieDetails}/$movieId');
    try {
      final response = await dio.get(
        '${ApiConstants.movieDetails}/$movieId',
        queryParameters: {'api_key': EnvConfig.tmdbApiKey, 'language': 'en-US'},
      );

      return MovieDetailsModel.fromJson(response.data);
    } on DioException catch (e) {
      Logger.e(e);
      throw ServerException(e.message ?? 'Failed to fetch movie detail');
    }
  }
}
