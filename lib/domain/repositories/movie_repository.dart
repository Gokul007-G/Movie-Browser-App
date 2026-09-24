import 'package:moviebrowserapp/domain/entities/movie.dart';
import 'package:moviebrowserapp/domain/entities/movie_details.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMovies({required int page});

  Future<MovieDetails> getMovieDetails({required int movieId});
}
