import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class TradeTypeSelection extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Trade Type",
          style: TextStyle(
            color: AppColors.textPrimaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Container(
          height: 60,
          decoration: AppColors.glassCardDecoration,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: const Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Market Order",
                style: TextStyle(
                  color: AppColors.textPrimaryColor,
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.textPrimaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

}