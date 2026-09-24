import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class MovieSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onClose;
  final ValueChanged<String>? onChanged;

  const MovieSearchBar({
    super.key,
    required this.controller,
    required this.onClose,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.divider,
        ),
      ),
      child: TextField(
        controller: controller,
        autofocus: true,
        onChanged: onChanged,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
        ),
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          hintText: 'Search movies...',
          hintStyle: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.textSecondary,
            size: 20,
          ),
          suffixIcon: IconButton(
            onPressed: onClose,
            icon: const Icon(
              Icons.close,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 11,
          ),
        ),
      ),
    );
  }
}