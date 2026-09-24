import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:moviebrowserapp/core/routes/app_routes.dart';
import 'package:moviebrowserapp/core/theme/app_colors.dart';
import 'package:moviebrowserapp/data/local/models/favorite_movie_model.dart';
import 'package:moviebrowserapp/presentation/favorite/favorite_page.dart';

class FavoriteMovieCard extends StatelessWidget {
  final FavoriteMovieModel movie;
  final VoidCallback onRemove;

  const FavoriteMovieCard({
    super.key,
    required this.movie,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final posterUrl = movie.posterPath != null
        ? '${FavoritePage.imageBaseUrl}${movie.posterPath}'
        : null;

    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.movieDetails, arguments: movie.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: double.infinity,
                    color: AppColors.surface,
                    child: posterUrl != null
                        ? CachedNetworkImage(
                            imageUrl: posterUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            placeholder: (context, url) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.primary,
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return const Icon(
                                Icons.movie_outlined,
                                color: AppColors.textMuted,
                                size: 45,
                              );
                            },
                          )
                        : const Icon(
                            Icons.movie_outlined,
                            color: AppColors.textMuted,
                            size: 45,
                          ),
                  ),
                ),

                // Dark gradient
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 90,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black87],
                      ),
                    ),
                  ),
                ),

                // Favorite button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.background.withOpacity(0.85),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: onRemove,
                      icon: const Icon(
                        Icons.favorite,
                        color: AppColors.primary,
                        size: 21,
                      ),
                    ),
                  ),
                ),

                // Rating
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.warning,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                // 18+
                if (movie.adult)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.background.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.error),
                      ),
                      child: const Text(
                        '18+',
                        style: TextStyle(
                          color: AppColors.error,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                // ─────────────────────────
                // Vote Count
                // ─────────────────────────
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: _MovieInfo(
                    icon: Icons.person,
                    rating: false,
                    value: formatVoteCount(movie.voteCount),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            movie.releaseDate.isNotEmpty
                ? movie.releaseDate.split('-').first
                : 'Unknown',
            style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

String formatVoteCount(int count) {
  if (count >= 1000000) {
    return '${(count / 1000000).toStringAsFixed(1)}M Votes';
  }

  if (count >= 1000) {
    return '${(count / 1000).toStringAsFixed(1)}K Votes';
  }

  return '$count Votes';
}

class _MovieInfo extends StatelessWidget {
  final IconData icon;
  final String value;
  final bool rating;

  const _MovieInfo({
    required this.icon,
    required this.value,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.85),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: rating ? AppColors.primary : AppColors.warning,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
