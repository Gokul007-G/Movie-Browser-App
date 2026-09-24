import 'package:flutter/material.dart';
import 'package:moviebrowserapp/core/theme/app_colors.dart';

class MetaItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const MetaItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 21),

        const SizedBox(height: 7),

        Text(
          title,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
        ),

        const SizedBox(height: 3),

        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
