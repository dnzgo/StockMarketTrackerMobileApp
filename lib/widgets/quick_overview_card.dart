import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/utils/app_theme.dart';
import 'package:intl/intl.dart';

class QuickOverviewCard extends StatelessWidget {
  final String type;
  final String symbol;
  final double quantity;
  final double price;
  final dynamic createdAt;
  final VoidCallback? onTap;

  const QuickOverviewCard({
    super.key,
    required this.type,
    required this.symbol,
    required this.quantity,
    required this.price,
    required this.createdAt,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isBuy = type.toLowerCase() == "buy";

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        width: 120,
        height: 110,
        margin: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 12,
        ),
        padding: const EdgeInsets.all(12),
        decoration: AppColors.transactionGlassDecoration(
          isBuy: isBuy,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  type.toUpperCase(),
                  style: TextStyle(
                    color: isBuy
                        ? AppColors.increasedValueColor
                        : AppColors.decreasedValueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 6),

                Expanded(
                  child: Text(
                    symbol,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textPrimaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 2),

            Text(
              "@${price.toStringAsFixed(2)}",
              style: const TextStyle(
                color: AppColors.textSecondaryColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),

            Text(
              "${quantity.toStringAsFixed(0)} Shares",
              style: const TextStyle(
                color: AppColors.textSecondaryColor,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              DateFormat("dd MMM").format(
                createdAt.toDate(),
              ),
              style: const TextStyle(
                color: AppColors.textSecondaryColor,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}