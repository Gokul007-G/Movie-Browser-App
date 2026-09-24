import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviebrowserapp/core/errors/logger.dart';
import 'package:moviebrowserapp/core/routes/app_routes.dart';
import 'package:moviebrowserapp/core/theme/app_colors.dart';
import 'package:moviebrowserapp/presentation/movie_details/widgets/error_view.dart';
import 'package:moviebrowserapp/presentation/movie_list/widgets/movie_app_bar.dart';

import '../controllers/movie_list_controller.dart';
import '../widgets/movie_card.dart';

class MovieListPage extends GetView<MovieListController> {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    final RxBool showGoToTop = false.obs;

    // Show button after scrolling down
    scrollController.addListener(() {
      if (scrollController.offset > 600) {
        if (!showGoToTop.value) {
          showGoToTop.value = true;
        }
      } else {
        if (showGoToTop.value) {
          showGoToTop.value = false;
        }
      }
    });

    return Scaffold(
      appBar: MovieAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (controller.errorMessage.isNotEmpty && controller.movies.isEmpty) {
          return ErrorView(
            message: controller.errorMessage.value,
            onRetry: controller.fetchMovies,
          );
        }

        // Search result empty
        if (controller.movies.isEmpty && controller.allMovies.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.movie_outlined,
                  color: AppColors.textMuted,
                  size: 60,
                ),

                const SizedBox(height: 16),

                const Text(
                  'Movie not found',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'No movies found for "${controller.searchController.text}"',
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                OutlinedButton(
                  onPressed: controller.clearSearch,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                  ),
                  child: const Text('Clear Search'),
                ),
              ],
            ),
          );
        }

        return Stack(
          children: [
            RefreshIndicator(
              onRefresh: controller.refreshMovies,
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent - 300) {
                    controller.loadMore();
                  }

                  return false;
                },
                child: GridView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.orientationOf(context) ==
                            Orientation.landscape
                        ? 5
                        : 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    childAspectRatio:
                        MediaQuery.orientationOf(context) ==
                            Orientation.landscape
                        ? 0.72
                        : 0.62,
                  ),
                  itemCount:
                      controller.movies.length +
                      (controller.isLoadingMore.value ? 1 : 0),
                  itemBuilder: (_, index) {
                    if (index >= controller.movies.length) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }

                    final movie = controller.movies[index];

                    return MovieCard(
                      movie: movie,
                      onTap: () {
                        Logger.i(AppRoutes.movieDetails);
                        Logger.i(movie.id);

                        Get.toNamed(
                          AppRoutes.movieDetails,
                          arguments: movie.id,
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            // Go to top button
            Obx(
              () => AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                right: 16,
                bottom: showGoToTop.value ? 20 : -70,
                child: FloatingActionButton.small(
                  heroTag: 'goToTop',
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textPrimary,
                  elevation: 5,
                  onPressed: () {
                    scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Icon(Icons.keyboard_arrow_up),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
