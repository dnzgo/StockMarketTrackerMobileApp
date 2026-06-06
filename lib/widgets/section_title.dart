import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class SectionTitle extends StatelessWidget{
  final String title;
  final String? actionText;
  const SectionTitle({
    super.key,
    required this.title,
    this.actionText
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
          ),

          actionText != null
              ? TextButton(onPressed: () {},
              child: Text(
                actionText!,
                style: TextStyle(
                  color: AppColors.textSecondaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              )
          )
              : SizedBox.shrink()

        ],
      ),
    );
  }

}