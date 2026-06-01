import 'package:flutter/material.dart';

class StockCard extends StatelessWidget{
  final String symbol;
  final String companyName;
  final double price;
  final double changePercentage;
  final bool isPositive;

  const StockCard({super.key,
    required this.symbol,
    required this.companyName,
    required this.price,
    required this.changePercentage,
    required this.isPositive
    });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(symbol),
              Text(companyName)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price.toStringAsFixed(2)),
              Text(changePercentage.toStringAsFixed(2))
            ],
          )
        ],
      ),
    );
  }

}