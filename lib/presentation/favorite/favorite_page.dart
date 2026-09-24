import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviebrowserapp/core/constants/api_constants.dart';
import 'package:moviebrowserapp/core/theme/app_colors.dart';
import 'package:moviebrowserapp/presentation/favorite/empty_favorite_view.dart';
import 'package:moviebrowserapp/presentation/favorite/favorite_controller.dart';
import 'package:moviebrowserapp/presentation/favorite/favorite_movie_card.dart';

class FavoritePage extends GetView<FavoriteController> {
  const FavoritePage({super.key});

  static const String imageBaseUrl = ApiConstants.imageBaseUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: const Text(
          'My Favorites',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Obx(() {
            if (controller.movies.isEmpty) {
              return const SizedBox.shrink();
            }

            return IconButton(
              onPressed: () {
                _showClearDialog(context);
              },
              icon: const Icon(
                Icons.delete_outline,
                color: AppColors.textSecondary,
              ),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.movies.isEmpty) {
          return const EmptyFavoriteView();
        }

        return RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          onRefresh: () async {
            controller.loadFavorites();
          },
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.orientationOf(context) == Orientation.landscape
                  ? 5
                  : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              childAspectRatio:
                  MediaQuery.orientationOf(context) == Orientation.landscape
                  ? 0.72
                  : 0.62,
            ),
            itemCount: controller.movies.length,
            itemBuilder: (context, index) {
              final movie = controller.movies[index];

              return FavoriteMovieCard(
                movie: movie,
                onRemove: () {
                  controller.removeFavorite(movie.id);
                },
              );
            },
          ),
        );
      }),
    );
  }

  void _showClearDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Clear Favorites?',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          'Are you sure you want to remove all favorite movies?',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.clearFavorites();
            },
            child: const Text(
              'Clear',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
