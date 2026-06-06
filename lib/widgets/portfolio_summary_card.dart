import 'package:flutter/material.dart';

class PortfolioSummaryCard extends StatelessWidget{
  final double totalValue;
  final double totalPnL;
  final double totalPnLPercentage;

  const PortfolioSummaryCard({
    super.key,
    required this.totalValue,
    required this.totalPnL,
    required this.totalPnLPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Total Balance"),
          SizedBox(height: 6,),
          Text(totalValue.toStringAsFixed(2) + "€"),
          SizedBox(height: 4,),
          Text(totalPnL.toStringAsFixed(2) + "€ (" + totalPnLPercentage.toStringAsFixed(2) + "%)"),
          SizedBox(height: 12,),
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
          ),
        ],
      ),
    );
  }

}