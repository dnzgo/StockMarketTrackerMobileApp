import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../widgets/portfolio_chart.dart';

class PortfolioSummaryCard extends StatelessWidget {

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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),

      child: SizedBox(
        height: 260,

        child: Stack(
          children: [

            // chart
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 70,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: PortfolioChart(),
              ),
            ),

            // balance info over chart
            Positioned(
              top: 0,
              left: 0,

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Total Balance",
                    style: TextStyle(
                      color:
                      AppColors.textPrimaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    "€${totalValue.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color:
                      AppColors.textPrimaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),

                    decoration: BoxDecoration(
                      color: isPositive
                          ? AppColors
                          .increasedValueColor
                          .withOpacity(0.15)
                          : AppColors
                          .decreasedValueColor
                          .withOpacity(0.15),

                      borderRadius:
                      BorderRadius.circular(12),
                    ),

                    child: Text(
                      "${totalPnL.toStringAsFixed(2)}€ "
                          "(${totalPnLPercentage.toStringAsFixed(2)}%)",

                      style: TextStyle(
                        color: isPositive
                            ? AppColors
                            .increasedValueColor
                            : AppColors
                            .decreasedValueColor,

                        fontSize: 15,
                        fontWeight:
                        FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}