import 'package:flutter/material.dart';
import 'package:moviebrowserapp/domain/entities/movie_details.dart';
import 'package:moviebrowserapp/presentation/movie_details/widgets/metaItem.dart';

class MovieMetaSection extends StatelessWidget {
  final MovieDetails movie;

  const MovieMetaSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MetaItem(
            icon: Icons.calendar_today_outlined,
            title: 'Release',
            value: formatDate(movie.releaseDate),
          ),
        ),

        Expanded(
          child: MetaItem(
            icon: Icons.access_time,
            title: 'Runtime',
            value: formatRuntime(movie.runtime),
          ),
        ),

        Expanded(
          child: MetaItem(
            icon: Icons.language,
            title: 'Language',
            value: movie.originalLanguage.toUpperCase(),
          ),
        ),
      ],
    );
  }

  String formatDate(String date) {
    if (date.isEmpty) {
      return 'Unknown';
    }

    try {
      final parsedDate = DateTime.parse(date);

      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];

      return '${months[parsedDate.month - 1]} ${parsedDate.day}, ${parsedDate.year}';
    } catch (_) {
      return date;
    }
  }

  String formatRuntime(int runtime) {
    if (runtime <= 0) {
      return 'N/A';
    }

    final hours = runtime ~/ 60;
    final minutes = runtime % 60;

    if (hours == 0) {
      return '${minutes}m';
    }

    if (minutes == 0) {
      return '${hours}h';
    }

    return '${hours}h ${minutes}m';
  }
}
