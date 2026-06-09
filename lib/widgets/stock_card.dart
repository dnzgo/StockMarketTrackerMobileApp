import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/utils/app_theme.dart';

class StockCard extends StatelessWidget{
  /*
  stockCard for home and stock screens to list stocks as cards,
  card shows: symbol of stock, company name
  price of share, change percentage,
  and card is clickable but interaction handled in screens with onTap
   */
  final String symbol;
  final String companyName;
  final double price;
  final double changePercentage;
  final bool isPositive;
  final VoidCallback onTap;

  const StockCard({super.key,
    required this.symbol,
    required this.companyName,
    required this.price,
    required this.changePercentage,
    required this.isPositive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        decoration: AppColors.glassCardDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  symbol,
                  style: const TextStyle(
                    color: AppColors.textSecondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  companyName,
                  style: const TextStyle(
                    color: AppColors.textPrimaryColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "€${price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: AppColors.textPrimaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${changePercentage.toStringAsFixed(2)}%",
                  style: TextStyle(
                    color: isPositive ? AppColors.increasedValueColor : AppColors.decreasedValueColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}