import 'package:get/get.dart';
import 'package:moviebrowserapp/data/local/favorite_movie_service.dart';
import 'package:moviebrowserapp/data/local/models/favorite_movie_model.dart';

class FavoriteController extends GetxController {
  final FavoriteMovieService favoriteMovieService;

  FavoriteController({
    required this.favoriteMovieService,
  });

  final movies = <FavoriteMovieModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() {
    movies.assignAll(
      favoriteMovieService.getFavorites(),
    );
  }

  Future<void> removeFavorite(int movieId) async {
    await favoriteMovieService.removeMovie(movieId);

    movies.removeWhere(
      (movie) => movie.id == movieId,
    );
  }

  Future<void> clearFavorites() async {
    final currentMovies = List<FavoriteMovieModel>.from(
      movies,
    );

    for (final movie in currentMovies) {
      await favoriteMovieService.removeMovie(movie.id);
    }

    movies.clear();
  }
}