import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:moviebrowserapp/core/routes/app_pages.dart';
import 'package:moviebrowserapp/core/routes/app_routes.dart';
import 'package:moviebrowserapp/core/theme/app_theme.dart';
import 'package:moviebrowserapp/data/local/favorite_movie_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  final favoriteMovieService = FavoriteMovieService();
  await favoriteMovieService.init();

  Get.put<FavoriteMovieService>(favoriteMovieService, permanent: true); 

  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Browser',
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.movie,
      getPages: AppPages.pages,
    );
  }
}
