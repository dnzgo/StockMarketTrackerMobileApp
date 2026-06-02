import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/widgets/stock_card.dart';

class StockExploreScreen extends StatefulWidget{
  const StockExploreScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StockExploreState();
}
class _StockExploreState extends State<StockExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Explore"),
      ),
      body: ListView(
        children: const [
          StockCard(
              symbol: "TSLA",
              companyName: "Tesla, Inc.",
              price: 354.4322,
              changePercentage: 2.333,
              isPositive: true
          ),
          StockCard(
              symbol: "TSLA",
              companyName: "Tesla, Inc.",
              price: 354.4322,
              changePercentage: 2.333,
              isPositive: true
          ),
          StockCard(
              symbol: "TSLA",
              companyName: "Tesla, Inc.",
              price: 354.4322,
              changePercentage: 2.333,
              isPositive: true
          ),
          StockCard(
              symbol: "TSLA",
              companyName: "Tesla, Inc.",
              price: 354.4322,
              changePercentage: 2.333,
              isPositive: true
          ),
          StockCard(
              symbol: "TSLA",
              companyName: "Tesla, Inc.",
              price: 354.4322,
              changePercentage: 2.333,
              isPositive: true
          ),
          StockCard(
              symbol: "TSLA",
              companyName: "Tesla, Inc.",
              price: 354.4322,
              changePercentage: 2.333,
              isPositive: true
          ),
          StockCard(
              symbol: "TSLA",
              companyName: "Tesla, Inc.",
              price: 354.4322,
              changePercentage: 2.333,
              isPositive: true
          ),
          StockCard(
              symbol: "TSLA",
              companyName: "Tesla, Inc.",
              price: 354.4322,
              changePercentage: 2.333,
              isPositive: true
          ),
          StockCard(
              symbol: "TSLA",
              companyName: "Tesla, Inc.",
              price: 354.4322,
              changePercentage: 2.333,
              isPositive: true
          ),
          StockCard(
              symbol: "TSLA",
              companyName: "Tesla, Inc.",
              price: 354.4322,
              changePercentage: 2.333,
              isPositive: true
          ),
        ],
      ),
    );
  }

}