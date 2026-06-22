import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../services/service_locator.dart';
import '../widgets/chart_period_selector.dart';
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

  List<FlSpot> portfolioChartSpots = [];
  bool isLoadingChart = true;

  Future<void> loadPortfolioChart() async {
    final spots =
    await portfolioChartService
        .buildPortfolioChartSpots(
      holdings: portfolioService.holdings,
      cashBalance: portfolioService.cashBalance,
    );

    if (!mounted) return;

    setState(() {
      portfolioChartSpots = spots;
      isLoadingChart = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPortfolioChart();
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
                  child : isLoadingChart
                      ? const Center(child: CircularProgressIndicator())
                      : ReusableLineChart(spots: portfolioChartSpots),
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
                    currencyService.formatPrice(widget.totalValue),
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
                      "${currencyService.formatPrice(widget.totalPnL)} "
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
          ],
        ),
      ),
    );
  }
}