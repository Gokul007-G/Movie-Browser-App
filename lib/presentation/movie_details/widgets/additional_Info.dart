import 'package:flutter/material.dart';
import 'package:moviebrowserapp/core/theme/app_colors.dart';
import 'package:moviebrowserapp/domain/entities/movie_details.dart';
import 'package:moviebrowserapp/presentation/movie_details/widgets/info_row.dart';
import 'package:moviebrowserapp/presentation/movie_details/widgets/selection_title.dart';

class AdditionalInfo extends StatelessWidget {
  final MovieDetails movie;

  const AdditionalInfo({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Movie Information'),

          const SizedBox(height: 16),

          InfoRow(title: 'Original Title', value: movie.originalTitle),

          InfoRow(title: 'Status', value: movie.status),

          InfoRow(
            title: 'Country',
            value: movie.productionCountries.isNotEmpty
                ? movie.productionCountries.first.name
                : 'Unknown',
          ),

          InfoRow(
            title: 'Language',
            value: movie.spokenLanguages.isNotEmpty
                ? movie.spokenLanguages.first.englishName
                : movie.originalLanguage.toUpperCase(),
          ),

          if (movie.productionCompanies.isNotEmpty)
            InfoRow(
              title: 'Production',
              value: movie.productionCompanies
                  .map((company) => company.name)
                  .join(', '),
            ),
        ],
      ),
    );
  }
}
