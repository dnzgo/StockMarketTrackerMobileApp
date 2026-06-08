import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class OrderSummaryCard extends StatelessWidget {

  final bool isBuySelected;
  final double quantity;
  final double price;

  const OrderSummaryCard({
    super.key,
    required this.isBuySelected,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text(
            "Order Summary",
            style: TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    "Price per Share:",
                    style: TextStyle(
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  const Text(
                    "Shares:",
                    style: TextStyle(
                        color: AppColors.textSecondaryColor
                    ),
                  ),
                  const Text(
                    "Trading Fee (0.1%):",
                    style: TextStyle(
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "€${price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  Text(
                    "€${((price * quantity) * 0.001).toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ],

              ),
            ],
          ),
          const Divider(
            color: AppColors.textSecondaryColor,
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total:",
                style: TextStyle(
                  color: AppColors.textPrimaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "€${(
                    isBuySelected
                        ? price * quantity * 1.001
                        : price * quantity * 0.999).toStringAsFixed(2
                )}",
                style: const TextStyle(
                  color: AppColors.textPrimaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      )
    );
  }

}