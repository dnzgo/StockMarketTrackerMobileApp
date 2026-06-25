import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CategoryChip extends StatelessWidget{
  /*
  Category chips for categories in category list, it shows category title and changes color if its selected,
  onTop handled by screen that has category selection
  */
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
        // add a margin to right of the chip, add a symmetric padding
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          // if selected use light blue color of app, otherwise white
          color: isSelected
              ? AppColors.backgroundLightingColor
              : Colors.white12,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          // title of category
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