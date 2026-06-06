import 'package:flutter/material.dart';
import '../widgets/stock_chart_card.dart';
import '../widgets/stock_info_card.dart';
import '../screens/trade_screen.dart';

class StockDetailScreen extends StatefulWidget{
  final String symbol;
  final String companyName;
  final double price;
  final double changePercentage;
  final bool isPositive;

  const StockDetailScreen({super.key,
    required this.symbol,
    required this.companyName,
    required this.price,
    required this.changePercentage,
    required this.isPositive
  });

  @override
  State<StatefulWidget> createState() => _StockDetailState();

}

class _StockDetailState extends State<StockDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.companyName),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.symbol),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(widget.price.toStringAsFixed(2)),
                      Text(widget.changePercentage.toStringAsFixed(2) + "%")
                    ],
                  )
                ],
              ),
              SizedBox(height: 24),
              StockChartCard(),

              SizedBox(height: 24),
              Text("Key Information"),
              SizedBox(height: 12),

              Row(
                children: [
                  StockInfoCard(title: "Market Cap", value: 3.5),
                  StockInfoCard(title: "Volume", value: 100),
                ],
              ),

              SizedBox(height: 12),

              Row(
                children: [
                  StockInfoCard(title: "P/E Ratio", value: 21.8),
                  StockInfoCard(title: "52W High", value: 488.12),
                ],
              ),

            ],
          ),
        )
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TradeScreen(
                      symbol: widget.symbol,
                      companyName: widget.companyName,
                      price: widget.price,
                    )
                  ),
                );
              },
              child: Text("Trade " + widget.symbol)
          ),
        ),
      ),

    );
  }

}