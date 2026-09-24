import 'package:flutter/material.dart';
import 'package:moviebrowserapp/core/theme/app_colors.dart';
import 'package:moviebrowserapp/domain/entities/movie_details.dart';
import 'package:moviebrowserapp/presentation/movie_list/widgets/movie_card.dart';

class RatingSection extends StatelessWidget {
  final MovieDetails movie;

  const RatingSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: AppColors.warning, size: 28),

          const SizedBox(width: 10),

          Text(
            movie.voteAverage.toStringAsFixed(1),
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Text(
            ' / 10',
            style: TextStyle(color: AppColors.textMuted, fontSize: 14),
          ),

          const SizedBox(width: 16),

          Container(width: 1, height: 28, color: AppColors.divider),

          const SizedBox(width: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatVoteCount(movie.voteCount),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'User Ratings',
                style: TextStyle(color: AppColors.textMuted, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
