import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviebrowserapp/core/theme/app_colors.dart';

import '../../../core/constants/api_constants.dart';
import '../../../domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieCard({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  // ─────────────────────────
                  // Movie Poster
                  // ─────────────────────────
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl:
                          '${ApiConstants.imageBaseUrl}${movie.posterPath}',
                      fit: BoxFit.cover,
                      placeholder: (_, __) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      },
                      errorWidget: (_, __, ___) {
                        return Container(
                          color: AppColors.surfaceLight,
                          child: const Center(
                            child: Icon(
                              Icons.movie_outlined,
                              color: AppColors.textMuted,
                              size: 40,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // ─────────────────────────
                  // Bottom Gradient
                  // ─────────────────────────
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 90,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.background.withOpacity(0.95),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // ─────────────────────────
                  // 18+ Badge
                  // ─────────────────────────
                  if (movie.adult)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 38,
                        height: 38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.error.withOpacity(0.90),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.textPrimary.withOpacity(0.8),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.error.withOpacity(0.35),
                              blurRadius: 8,
                              spreadRadius: 1,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Text(
                          '18+',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),

                  // ─────────────────────────
                  // Rating
                  // ─────────────────────────
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: _MovieInfo(
                      icon: Icons.star,
                      rating: true,
                      value: '${movie.voteAverage.toStringAsFixed(1)}/10',
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
          ),

          const SizedBox(height: 8),

          // ─────────────────────────
          // Movie Title
          // ─────────────────────────
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
