import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/utils/app_theme.dart';

import '../services/service_locator.dart';

class QuickOverviewCard extends StatelessWidget{
  /*
  Quick overview card shows stock Indexes with name, price value, and percentage
   */
  final String marketName;
  final double marketValue;
  final double changePercentage;

  const QuickOverviewCard({
    super.key,
    required this.marketName,
    required this.marketValue,
    required this.changePercentage
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(12),
      decoration: AppColors.glassCardDecoration,
      child: Column(
        children: [
          Text(marketName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${currencyService.currencySymbol}${marketValue.toStringAsFixed(2)}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${changePercentage.toStringAsFixed(2)}%",
            style: TextStyle(
              color: changePercentage > 0 ? AppColors.increasedValueColor : AppColors.decreasedValueColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

}