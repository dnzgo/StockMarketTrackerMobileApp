import 'package:flutter/material.dart';
import '../models/portfolio_holding.dart';
import '../utils/app_theme.dart';

class HoldingCard extends StatelessWidget{
  final PortfolioHolding holding;
  final VoidCallback onTap;

  const HoldingCard({
    super.key,
    required this.holding,
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
                  holding.stock.symbol,
                  style: const TextStyle(
                    color: AppColors.textSecondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "€${holding.stock.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: AppColors.textSecondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "€${holding.currentValue.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: AppColors.textSecondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "€${holding.profitLoss.toStringAsFixed(2)}"
                  "(${holding.profitLossPercentage.toStringAsFixed(2)}%)",
                  style: TextStyle(
                    color: holding.isPositive ? AppColors.increasedValueColor : AppColors.decreasedValueColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}