import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class SectionTitle extends StatelessWidget{
  /*
  to separate sections we use this card to show section name,
  also a clickable text can be put to go related screen but that is optional
   */
  final String title;
  final String? actionText;
  final VoidCallback? onTap;

  const SectionTitle({
    super.key,
    required this.title,
    this.actionText,
    this.onTap,
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
              ? InkWell(onTap: onTap,
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