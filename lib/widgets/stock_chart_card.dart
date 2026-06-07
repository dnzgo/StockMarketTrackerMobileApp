import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/utils/app_theme.dart';

class StockChartCard extends StatefulWidget {
  const StockChartCard({super.key});

  @override
  State<StockChartCard> createState() => _StockChartState();
}

class _StockChartState extends State<StockChartCard> {
  int selectedIndex = 0;

  final List<String> periods = [
    "1D",
    "1W",
    "1M",
    "3M",
    "1Y",
    "5Y",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: [
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.textPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              periods.length,
                  (index) {
                final bool isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: isSelected
                        ? AppColors.glassButtonDecoration
                        : null,
                    child: Text(
                      periods[index],
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.textPrimaryColor
                            : AppColors.textSecondaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}