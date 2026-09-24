import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviebrowserapp/core/constants/api_constants.dart';
import 'package:moviebrowserapp/core/theme/app_colors.dart';
import 'package:moviebrowserapp/domain/entities/movie_details.dart';

class Poster extends StatelessWidget {
  final MovieDetails movie;

  const Poster(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
      height: 165,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl:
            '${ApiConstants.imageBaseUrl}${movie.posterPath}',
        fit: BoxFit.cover,

        placeholder: (_, __) {
          return Container(
            color: AppColors.surfaceLight,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          );
        },

        errorWidget: (_, __, ___) {
          return Container(
            color: AppColors.surfaceLight,
            child: const Icon(
              Icons.movie_outlined,
              color: AppColors.textMuted,
              size: 40,
            ),
          );
        },
      ),
    );
  }
}