import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/utils/app_theme.dart';

class StockInfoCard extends StatelessWidget{
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
      height: 80,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "€${value.toStringAsFixed(2)}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

}