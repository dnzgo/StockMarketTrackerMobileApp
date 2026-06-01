import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/widgets/stock_card.dart';
import 'package:stock_market_tracker_mobile_app/widgets/section_title.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          Text("Welcome"),
          Text("Country: Germany"),
          Text("Market Overview"),
          Text("AAPL  +1.2%"),
          SectionTitle(title: "Trending Stock" , actionText: "See All"),
          StockCard(symbol: "TSLA", companyName: "Tesla, Inc.", price: 354.4322, changePercentage: 2.333, isPositive: true),
          StockCard(symbol: "TSLA", companyName: "Tesla, Inc.", price: 354.4322, changePercentage: 2.333, isPositive: true),
        ],

      ),
    );
  }

}