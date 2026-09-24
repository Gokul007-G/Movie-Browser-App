import 'package:get/get.dart';
import 'package:moviebrowserapp/core/routes/app_routes.dart';
import 'package:moviebrowserapp/presentation/favorite/favorite_binding.dart';
import 'package:moviebrowserapp/presentation/favorite/favorite_page.dart';
import 'package:moviebrowserapp/presentation/movie_details/bindings/movie_detail_binding.dart';
import 'package:moviebrowserapp/presentation/movie_details/pages/movie_detail_page.dart';
import 'package:moviebrowserapp/presentation/movie_list/bindinds/movie_list_binding.dart';
import 'package:moviebrowserapp/presentation/movie_list/pages/movie_list_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.movie,
      page: () => const MovieListPage(),
      binding: MovieListBinding(),
    ),

    GetPage(
      name: AppRoutes.movieDetails,
      page: () => const MovieDetailPage(),
      binding: MovieDetailBinding(),
    ),

    GetPage(
      name: AppRoutes.favoriteMovies,
      page: () => const FavoritePage(),
      binding: FavoriteBinding(),
    ),
  ];
}
