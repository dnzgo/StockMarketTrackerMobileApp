import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/widgets/reusable_line_chart.dart';
import '../utils/app_theme.dart';
import '../widgets/chart_period_selector.dart';

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

  List<FlSpot> get stockChartData {
    switch (periods[selectedIndex]) {

      case "1D":
        return const [
          FlSpot(0, 320),
          FlSpot(1, 325),
          FlSpot(2, 318),
          FlSpot(3, 330),
          FlSpot(4, 327),
          FlSpot(5, 334),
          FlSpot(6, 319),
        ];

      case "1W":
        return const [
          FlSpot(0, 300),
          FlSpot(1, 308),
          FlSpot(2, 295),
          FlSpot(3, 315),
          FlSpot(4, 310),
          FlSpot(5, 322),
          FlSpot(6, 321),
        ];

      case "1M":
        return const [
          FlSpot(0, 280),
          FlSpot(1, 295),
          FlSpot(2, 310),
          FlSpot(3, 298),
          FlSpot(4, 320),
          FlSpot(5, 340),
          FlSpot(6, 321),
        ];

      case "3M":
        return const [
          FlSpot(0, 220),
          FlSpot(1, 240),
          FlSpot(2, 270),
          FlSpot(3, 260),
          FlSpot(4, 290),
          FlSpot(5, 315),
          FlSpot(6, 321),
        ];

      case "1Y":
        return const [
          FlSpot(0, 150),
          FlSpot(1, 170),
          FlSpot(2, 190),
          FlSpot(3, 220),
          FlSpot(4, 260),
          FlSpot(5, 300),
          FlSpot(6, 321),
        ];

      case "5Y":
        return const [
          FlSpot(0, 45),
          FlSpot(1, 60),
          FlSpot(2, 85),
          FlSpot(3, 130),
          FlSpot(4, 190),
          FlSpot(5, 260),
          FlSpot(6, 321),
        ];

      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: [

          ReusableLineChart(
            spots: stockChartData,
          ),

          const SizedBox(height: 12),

          ChartPeriodSelector(
            selectedIndex: selectedIndex,
            periods: periods,
            onChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            }
          ),
        ],
      ),
    );
  }
}