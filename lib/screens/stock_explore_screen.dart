import 'package:flutter/material.dart';
import '../models/stock.dart';
import '../screens/stock_detail_screen.dart';
import '../widgets/stock_card.dart';
import '../widgets/search_bar.dart';

class StockExploreScreen extends StatefulWidget{
  const StockExploreScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StockExploreState();
}
class _StockExploreState extends State<StockExploreScreen> {

  final List<Stock> stocks = [
    Stock(
      symbol: 'TSLA',
      companyName: 'Tesla, Inc.',
      price: 321.33,
      changePercentage: -1.2,
    ),
    Stock(
        symbol: 'NVDA',
        companyName: 'NVIDIA',
        price: 142.81,
        changePercentage: 2.4,
    ),
    Stock(
        symbol: 'TSLA',
        companyName: 'Tesla, Inc.',
        price: 321.33,
        changePercentage: -1.2
    ),
  ];

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
                        // spread operator (...) used children expects individual widgets
                        // but stock.map returns a list spread operator unwraps the list items
                        // into children one by one
                        ...stocks.map((stock) {
                          return StockCard(
                            symbol: stock.symbol,
                              companyName: stock.companyName,
                              price: stock.price,
                              changePercentage: stock.changePercentage,
                              isPositive: stock.isPositive,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StockDetailScreen(
                                      symbol: stock.symbol,
                                      companyName: stock.companyName,
                                      price: stock.price,
                                      changePercentage: stock.changePercentage,
                                      isPositive: stock.isPositive,
                                    ),
                                  ),
                                );
                              },
                          );
                        }).toList()
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