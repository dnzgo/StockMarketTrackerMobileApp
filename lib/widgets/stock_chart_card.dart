import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../services/stock_service.dart';
import '../widgets/reusable_line_chart.dart';
import '../widgets/chart_period_selector.dart';
import '../utils/app_theme.dart';

class StockChartCard extends StatefulWidget {
  final String symbol;
  final Function(List<FlSpot>)? onChartDataChanged;

  const StockChartCard({
    super.key,
    required this.symbol,
    this.onChartDataChanged,
  });

  @override
  State<StockChartCard> createState() => _StockChartState();
}

class _StockChartState extends State<StockChartCard> {
  final stockService = StockService();

  int selectedIndex = 0;

  List<FlSpot> chartSpots = [];
  bool isLoadingChart = true;


  final List<String> periods = [
    "1D",
    "1W",
    "1M",
    "3M",
    "1Y",
    "5Y",
  ];


  Future<void> loadChartData() async {
    setState(() {
      isLoadingChart = true;
      chartSpots = [];
    });

    try {
      final loadedSpots = await stockService.getChartData(
        widget.symbol,
        periods[selectedIndex],
      );

      if(!mounted) return;

      setState(() {
        chartSpots = loadedSpots;
        isLoadingChart = false;
      });
      
      widget.onChartDataChanged?.call(loadedSpots);

    } catch(e) {
      print("chart loading error: $e");

      if(!mounted) return;

      setState(() {
        isLoadingChart = false;
        chartSpots = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadChartData();
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

          isLoadingChart
              ? const SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
              : chartSpots.isEmpty
                ? const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text("No chart data available!",
                      style: TextStyle(
                        color: AppColors.textSecondaryColor,
                      ),
                      ),
                  ),
                )
                : ReusableLineChart(
                    spots: chartSpots,
                ),

          const SizedBox(height: 12),

          ChartPeriodSelector(
            selectedIndex: selectedIndex,
            periods: periods,
            onChanged: (index) {
              setState(() {
                selectedIndex = index;
              });

              loadChartData();
            }
          ),
        ],
      ),
    );
  }
}