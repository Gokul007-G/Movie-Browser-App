import 'package:get/get.dart';
import 'package:moviebrowserapp/data/local/favorite_movie_service.dart';
import 'package:moviebrowserapp/presentation/favorite/favorite_controller.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteController>(
      () => FavoriteController(
        favoriteMovieService: Get.find<FavoriteMovieService>(),
      ),
    );
  }
}