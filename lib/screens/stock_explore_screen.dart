import 'package:flutter/material.dart';
import '../screens/stock_detail_screen.dart';
import '../widgets/stock_card.dart';
import '../widgets/search_bar.dart';

class StockExploreScreen extends StatefulWidget{
  const StockExploreScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StockExploreState();
}
class _StockExploreState extends State<StockExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Stocks",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                          isPositive: false,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StockDetailScreen(
                                  symbol: "TSLA",
                                  companyName: "Tesla Inc.",
                                  price: 321.333,
                                  changePercentage: -1.2,
                                  isPositive: false,
                                )
                              )
                            );
                          },
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