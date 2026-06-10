import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CashBalanceCard extends StatelessWidget{
  /*
  stockCard for home and stock screens to list stocks as cards,
  card shows: symbol of stock, company name
  price of share, change percentage,
  and card is clickable but interaction handled in screens with onTap
   */
  final String cashType;
  final double value;

  const CashBalanceCard({super.key,
    required this.cashType,
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
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      decoration: AppColors.glassCardDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cashType,
                style: const TextStyle(
                  color: AppColors.textSecondaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "€${value.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: AppColors.textPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}