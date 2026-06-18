import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/app_theme.dart';

class ReusableLineChart extends StatelessWidget{

  final List<FlSpot> spots;

  const ReusableLineChart({
    super.key,
    required this.spots,
  });

  bool get isPositive {
    return spots.last.y >= spots.first.y;
  }

  @override
  Widget build(BuildContext context) {
    final chartColor = isPositive
        ? AppColors.increasedValueColor
        : AppColors.decreasedValueColor;

    return SizedBox( // container for chart
      height: 200,
      child: LineChart(
        LineChartData(
          backgroundColor: Colors.transparent,

          gridData: const FlGridData(
            show: false,
          ),

          borderData: FlBorderData(
            show: false,
          ),

          titlesData: const FlTitlesData(
            show: false,
          ),

          lineBarsData: [
            LineChartBarData(
              isCurved: false,
              spots: spots,
              color: chartColor,
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),

              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    chartColor.withOpacity(0.20),
                    chartColor.withOpacity(0.00),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}