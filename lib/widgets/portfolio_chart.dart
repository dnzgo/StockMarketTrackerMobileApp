import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/app_theme.dart';

class PortfolioChart extends StatelessWidget{

  const PortfolioChart({super.key});

  @override
  Widget build(BuildContext context) {
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
              isCurved: true,
              spots: const [
                FlSpot(0, 9000),
                FlSpot(1, 9500),
                FlSpot(2, 6000),
                FlSpot(3, 5500),
                FlSpot(4, 10100),
                FlSpot(5, 9950),
                FlSpot(6, 10500),
              ],

              color: AppColors.increasedValueColor,
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),

              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.increasedValueColor
                        .withOpacity(0.35),
                    AppColors.increasedValueColor
                        .withOpacity(0.00),
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