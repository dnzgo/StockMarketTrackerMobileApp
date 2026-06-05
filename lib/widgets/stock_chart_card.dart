import 'package:flutter/material.dart';

class StockChartCard extends StatefulWidget{

  const StockChartCard({super.key});

  @override
  State<StatefulWidget> createState() => _StockChartState();

}

class _StockChartState extends State<StockChartCard>{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: [
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
          ),
          SizedBox(height: 6,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: () {}, child: Text("1D")),
              TextButton(onPressed: () {}, child: Text("7D")),
              TextButton(onPressed: () {}, child: Text("1M")),
              TextButton(onPressed: () {}, child: Text("1Y")),
              TextButton(onPressed: () {}, child: Text("5Y")),
              TextButton(onPressed: () {}, child: Text("All")),
            ],
          )
        ],
      ),
    );
  }

}