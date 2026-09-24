import 'package:moviebrowserapp/core/errors/exceptions.dart';
import 'package:moviebrowserapp/core/errors/failures.dart';
import 'package:moviebrowserapp/data/datasources/movie_remote_datasource.dart';
import 'package:moviebrowserapp/domain/entities/movie.dart';
import 'package:moviebrowserapp/domain/entities/movie_details.dart';
import 'package:moviebrowserapp/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource movieRemoteDatasource;

  MovieRepositoryImpl({required this.movieRemoteDatasource});

  @override
  Future<List<Movie>> getMovies({required int page}) async {
    try {
      return await movieRemoteDatasource.getMovies(page: page);
    } on ServerException catch (e) {
      throw Failures(e.message);
    }
  }

  @override
  Future<MovieDetails> getMovieDetails({required int movieId}) async {
    try {
      return await movieRemoteDatasource.getMoviesDetails(movieId: movieId);
    } on ServerException catch (e) {
      throw Failures(e.message);
    }
  }
}
