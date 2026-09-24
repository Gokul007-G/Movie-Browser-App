import 'package:moviebrowserapp/domain/entities/movie.dart';
import 'package:moviebrowserapp/domain/repositories/movie_repository.dart';

class GetMovies {
  final MovieRepository repository;

  GetMovies({required this.repository});

  Future<List<Movie>> call({required int page}) async {
    return repository.getMovies(page: page);
  }
}
