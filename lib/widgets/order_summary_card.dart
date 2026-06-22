import 'package:flutter/material.dart';
import '../services/service_locator.dart';
import '../utils/app_theme.dart';

class OrderSummaryCard extends StatelessWidget {
  /*
  Order summary card shows order related data like
  stock share price, quantity that selected, fee, total price
   */

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Order Summary",
            style: TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Price per Share:",
                    style: TextStyle(
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 8,),
                  const Text(
                    "Shares:",
                    style: TextStyle(
                        color: AppColors.textSecondaryColor
                    ),
                  ),
                  SizedBox(height: 8,),
                  const Text(
                    "Trading Fee (0.1%):",
                    style: TextStyle(
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${currencyService.currencySymbol}${price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "${currencyService.currencySymbol}${((price * quantity) * 0.001).toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ],

              ),
            ],
          ),
          SizedBox(height: 8,),
          const Divider(
            color: AppColors.textSecondaryColor,
          ),
          SizedBox(height: 8,),
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
                "${currencyService.currencySymbol}${(
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
          SizedBox(height: 40,),
        ],
      )
    );
  }

}