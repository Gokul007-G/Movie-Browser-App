import 'package:get/get.dart';
import 'package:moviebrowserapp/core/errors/failures.dart';
import 'package:moviebrowserapp/data/local/favorite_movie_service.dart';
import 'package:moviebrowserapp/data/local/models/favorite_movie_model.dart';
import 'package:moviebrowserapp/domain/entities/movie_details.dart';
import 'package:moviebrowserapp/domain/usecases/get_movie_detail.dart';

class MovieDetailController extends GetxController {
  final GetMovieDetail getMovieDetail;
  final FavoriteMovieService favoriteMovieService;

  MovieDetailController({
    required this.getMovieDetail,
    required this.favoriteMovieService,
  });

  final movie = Rxn<MovieDetails>();

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final isFavorite = false.obs;

  late int movieId;

  @override
  void onInit() {
    super.onInit();

    movieId = Get.arguments as int;

    fetchMovieDetail();
  }

  Future<void> fetchMovieDetail() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await getMovieDetail(movieId: movieId);

      movie.value = result;

      isFavorite.value = favoriteMovieService.isFavorite(result.id);
    } on Failures catch (e) {
      errorMessage.value = e.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite() async {
    final currentMovie = movie.value;

    if (currentMovie == null) return;

    if (isFavorite.value) {
      await favoriteMovieService.removeMovie(currentMovie.id);

      isFavorite.value = false;

      Get.snackbar(
        'Removed',
        '${currentMovie.title} removed from favorites',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      final favoriteMovie = FavoriteMovieModel(
        id: currentMovie.id,
        title: currentMovie.title,
        posterPath: currentMovie.posterPath,
        backdropPath: currentMovie.backdropPath,
        overview: currentMovie.overview,
        releaseDate: currentMovie.releaseDate,
        voteAverage: currentMovie.voteAverage,
        voteCount: currentMovie.voteCount,
        runtime: currentMovie.runtime,
        adult: currentMovie.adult,
        tagline: currentMovie.tagline,
        originalTitle: currentMovie.originalTitle,
        originalLanguage: currentMovie.originalLanguage,
        status: currentMovie.status,
        genres: currentMovie.genres.map((genre) => genre.name).toList(),
      );

      await favoriteMovieService.addMovie(favoriteMovie);

      isFavorite.value = true;

      Get.snackbar(
        'Added',
        '${currentMovie.title} added to favorites',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
