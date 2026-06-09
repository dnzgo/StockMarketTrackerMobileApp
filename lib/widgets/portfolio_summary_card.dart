import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class PortfolioSummaryCard extends StatelessWidget{
  /*
  Portfolio Summary Card shows balance, PnL,PnL percentage
   */
  final double totalValue;
  final double totalPnL;
  final double totalPnLPercentage;
  final bool isPositive;

  const PortfolioSummaryCard({
    super.key,
    required this.totalValue,
    required this.totalPnL,
    required this.totalPnLPercentage,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Value",
            style: const TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 6,),
          Text(
            totalValue.toStringAsFixed(2) + "€",
            style: const TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 0,),
          Text(
            "${totalPnL.toStringAsFixed(2)}€ (${totalPnLPercentage.toStringAsFixed(2)}%)",
            style: TextStyle(
              color: isPositive
                ? AppColors.increasedValueColor
                : AppColors.decreasedValueColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12,),
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(10)
            ),
          ),
        ],
      ),
    );
  }

}