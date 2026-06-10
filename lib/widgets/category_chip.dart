import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CategoryChip extends StatelessWidget{
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.backgroundLightingColor
              : Colors.white12,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

}