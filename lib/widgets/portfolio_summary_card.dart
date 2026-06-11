import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/widgets/chart_period_selector.dart';
import '../utils/app_theme.dart';
import '../widgets/reusable_line_chart.dart';

class PortfolioSummaryCard extends StatefulWidget {

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
  State<StatefulWidget> createState() => _PortfolioSummaryState();
}

class _PortfolioSummaryState extends State<PortfolioSummaryCard> {

  int selectedIndex = 0;

  final List<String> periods = [
    "1D",
    "1W",
    "1M",
    "3M",
    "1Y",
    "5Y",
  ];

  List<FlSpot> get chartData {
    switch (periods[selectedIndex]) {

      case "1D":
        return const [
          FlSpot(0, 9800),
          FlSpot(1, 10100),
          FlSpot(2, 9950),
          FlSpot(3, 10300),
          FlSpot(4, 10050),
        ];

      case "1W":
        return const [
          FlSpot(0, 9200),
          FlSpot(1, 9500),
          FlSpot(2, 9400),
          FlSpot(3, 9800),
          FlSpot(4, 10200),
        ];

      case "1M":
        return const [
          FlSpot(0, 10500),
          FlSpot(1, 10200),
          FlSpot(2, 9800),
          FlSpot(3, 9400),
          FlSpot(4, 9100),
        ];

      case "3M":
        return const [
          FlSpot(0, 8500),
          FlSpot(1, 8900),
          FlSpot(2, 9200),
          FlSpot(3, 9800),
          FlSpot(4, 10400),
        ];

      case "1Y":
        return const [
          FlSpot(0, 6000),
          FlSpot(1, 7200),
          FlSpot(2, 8100),
          FlSpot(3, 9300),
          FlSpot(4, 10400),
        ];

      case "5Y":
        return const [
          FlSpot(0, 3000),
          FlSpot(1, 4500),
          FlSpot(2, 6500),
          FlSpot(3, 8500),
          FlSpot(4, 10400),
        ];

      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),

      child: SizedBox(
        height: 300,

        child: Stack(
          children: [

            // chart
            Positioned(
              left: 0,
              right: 0,
              bottom: 50,
              top: 70,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ReusableLineChart(
                  spots: chartData,
                ),
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
                    "€${widget.totalValue.toStringAsFixed(2)}",
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
                      color: widget.isPositive
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
                      "${widget.totalPnL.toStringAsFixed(2)}€ "
                          "(${widget.totalPnLPercentage.toStringAsFixed(2)}%)",

                      style: TextStyle(
                        color: widget.isPositive
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
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,

              child: ChartPeriodSelector(
                selectedIndex: selectedIndex,
                periods: periods,

                onChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}