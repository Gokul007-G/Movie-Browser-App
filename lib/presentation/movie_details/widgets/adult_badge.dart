import 'package:flutter/material.dart';
import 'package:moviebrowserapp/core/theme/app_colors.dart';

class AdultBadge extends StatelessWidget {
  const AdultBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.9),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.error,
          width: 2,
        ),
      ),
      child: const Text(
        '18+',
        style: TextStyle(
          color: AppColors.error,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}