import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class StockInfoCard extends StatelessWidget {
  /*
  Stock info card for show stock statistics in stock detail screen, like open price, high price etc.
   */
  final String title;
  final double value;

  const StockInfoCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 100,
      margin: const EdgeInsets.only(
        right: 8,
        top: 8,
        bottom: 8,
      ),
      padding: const EdgeInsets.all(12),
      decoration: AppColors.glassCardDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textSecondaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            value.toStringAsFixed(2),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}