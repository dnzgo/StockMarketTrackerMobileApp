import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class AffectedStockChip extends StatelessWidget{
  /*
  Affected stock chip for news detail screen to show stocks affected from news
  small card that only shows symbol and change percentage
   */
  final String symbol;
  final double changePercentage;
  final bool isPositive;
  final VoidCallback onTap;

  const AffectedStockChip({
    super.key,
    required this.symbol,
    required this.changePercentage,
    required this.isPositive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 90,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(symbol),
            Text(
              "${changePercentage.toStringAsFixed(2)}%",
              style: TextStyle(
                color: isPositive
                    ? AppColors.increasedValueColor
                    : AppColors.decreasedValueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

}