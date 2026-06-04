import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/widgets/stock_card.dart';
import 'package:stock_market_tracker_mobile_app/widgets/search_bar.dart';

class StockExploreScreen extends StatefulWidget{
  const StockExploreScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StockExploreState();
}
class _StockExploreState extends State<StockExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
                child: Column(
                  children: [
                    Text("Stocks"),
                    SizedBox(height: 4),
                    SearchBarWidget(hintText: "Search Stocks...", onChanged: (text) {},),
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        StockCard(
                            symbol: "TSLA",
                            companyName: "Tesla Inc.",
                            price: 321.333,
                            changePercentage: -1.2,
                            isPositive: false
                        ),
                        StockCard(
                            symbol: "TSLA",
                            companyName: "Tesla Inc.",
                            price: 321.333,
                            changePercentage: -1.2,
                            isPositive: false
                        ),
                        StockCard(
                            symbol: "TSLA",
                            companyName: "Tesla Inc.",
                            price: 321.333,
                            changePercentage: -1.2,
                            isPositive: false
                        ),
                        StockCard(
                            symbol: "TSLA",
                            companyName: "Tesla Inc.",
                            price: 321.333,
                            changePercentage: -1.2,
                            isPositive: false
                        ),
                        StockCard(
                            symbol: "TSLA",
                            companyName: "Tesla Inc.",
                            price: 321.333,
                            changePercentage: -1.2,
                            isPositive: false
                        ),
                        StockCard(
                            symbol: "TSLA",
                            companyName: "Tesla Inc.",
                            price: 321.333,
                            changePercentage: -1.2,
                            isPositive: false
                        ),
                        StockCard(
                            symbol: "TSLA",
                            companyName: "Tesla Inc.",
                            price: 321.333,
                            changePercentage: -1.2,
                            isPositive: false
                        ),
                      ],
                    ),
                  )
              )
            ],
      )
      )
    );
  }

}