import 'package:flutter/material.dart';
import 'package:moviebrowserapp/core/theme/app_colors.dart';
import 'package:moviebrowserapp/domain/entities/movie_details.dart';

class GenreList extends StatelessWidget {
  final List<Genre> genres;

  const GenreList({
    required this.genres,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: genres.map((genre) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.35),
            ),
          ),
          child: Text(
            genre.name,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }
}