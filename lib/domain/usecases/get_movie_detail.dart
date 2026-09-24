import 'package:moviebrowserapp/domain/entities/movie_details.dart';
import 'package:moviebrowserapp/domain/repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail({required this.repository});

  Future<MovieDetails> call({required int movieId}) async {
    return repository.getMovieDetails(movieId: movieId);
  }
}
