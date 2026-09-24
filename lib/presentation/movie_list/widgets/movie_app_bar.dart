import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviebrowserapp/core/routes/app_routes.dart';

import '../controllers/movie_list_controller.dart';
import 'movie_search_bar.dart';
import '../../../core/theme/app_colors.dart';

class MovieAppBar extends GetView<MovieListController>
    implements PreferredSizeWidget {
  const MovieAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _showFilterBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.tune_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Text(
                    'Filter Movies',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                IconButton(
                  onPressed: () {
                    controller.assignAllMovies();
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            const Text(
              'Filter by rating',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),

            const SizedBox(height: 16),

            // All ratings
            _ratingOption(
              title: 'All Movies',
              subtitle: 'Show all movies',
              rating: null,
            ),

            _ratingOption(
              title: '8.0+',
              subtitle: 'Excellent movies',
              rating: 8.0,
            ),

            _ratingOption(
              title: '7.0+',
              subtitle: 'Highly rated movies',
              rating: 7.0,
            ),

            _ratingOption(
              title: '6.0+',
              subtitle: 'Good rated movies',
              rating: 6.0,
            ),

            _ratingOption(
              title: '5.0+',
              subtitle: 'Movies rated 5 or higher',
              rating: 5.0,
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _ratingOption({
    required String title,
    required String subtitle,
    required double? rating,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        controller.filterByRating(rating);
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.star_rounded,
                color: AppColors.warning,
                size: 22,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppBar(
        automaticallyImplyLeading: false,
        title: controller.isSearch.value
            ? MovieSearchBar(
                controller: controller.searchController,
                onClose: controller.closeSearch,
                onChanged: controller.searchMovies,
              )
            : Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.asset(
                        'assets/app_icon_1024.png',
                        width: 28,
                        height: 28,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Popular Movies',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Chennai',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

        actions: controller.isSearch.value
            ? null
            : [
                // Search
                IconButton(
                  onPressed: controller.openSearch,
                  icon: const Icon(Icons.search_rounded),
                ),

                // Filter
                Obx(
                  () => IconButton(
                    onPressed: () {
                      if (controller.isFilter.value) {
                        controller.assignAllMovies();
                      } else {
                        _showFilterBottomSheet(context);
                      }
                    },
                    icon: Icon(
                      controller.isFilter.value
                          ? Icons.filter_alt_off_rounded
                          : Icons.tune_rounded,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: controller.isFilter.value
                          ? AppColors.primary.withOpacity(0.20)
                          : AppColors.primary.withOpacity(0.12),
                      foregroundColor: AppColors.primary,
                      shape: const CircleBorder(),
                    ),
                  ),
                ),

                // Favorites
                IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.favoriteMovies);
                  },
                  icon: const Icon(
                    Icons.favorite_rounded,
                    color: AppColors.primary,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primary.withOpacity(0.12),
                    foregroundColor: AppColors.primary,
                    shape: const CircleBorder(),
                  ),
                ),

                const SizedBox(width: 8),
              ],
      ),
    );
  }
}
