import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class ChartPeriodSelector extends StatelessWidget {
  /*
  for Charts reusable period selection each period has a index
  and selected index changes visual of period button,
  also onTap called from screen that uses period selector
  */
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

            child: AnimatedContainer( // when selecting a period animate change(no instant change)
              duration:
              const Duration(milliseconds: 250),

              padding:
              const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),

              decoration: isSelected // change decoration if selected
                  ? AppColors.glassButtonDecoration
                  : null,

              child: Text(
                periods[index],
                style: TextStyle(
                  color: isSelected // change text color if selected
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