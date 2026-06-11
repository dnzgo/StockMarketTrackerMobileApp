import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class ChartPeriodSelector extends StatelessWidget {
  final int selectedIndex;
  final List<String> periods;
  final ValueChanged<int> onChanged;

  const ChartPeriodSelector({
    super.key,
    required this.selectedIndex,
    required this.periods,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,

      children: List.generate(
        periods.length,
            (index) {

          final isSelected =
              selectedIndex == index;

          return GestureDetector(
            onTap: () => onChanged(index),

            child: AnimatedContainer(
              duration:
              const Duration(milliseconds: 250),

              padding:
              const EdgeInsets.symmetric(
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
                      ? AppColors
                      .textPrimaryColor
                      : AppColors
                      .textSecondaryColor,

                  fontWeight:
                  FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}