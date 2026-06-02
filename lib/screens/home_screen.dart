import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/widgets/stock_card.dart';
import 'package:stock_market_tracker_mobile_app/widgets/section_title.dart';
import 'package:stock_market_tracker_mobile_app/widgets/quick_overview_card.dart';

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
          Row(
            children: [
              QuickOverviewCard(marketName: "NASDAQ", marketValue: 2323, changePercentage: 2.33),
              QuickOverviewCard(marketName: "NASDAQ", marketValue: 2323, changePercentage: 2.33),
              QuickOverviewCard(marketName: "NASDAQ", marketValue: 2323, changePercentage: 2.33),
            ],
          ),
          SectionTitle(title: "Trending Stock" , actionText: "See All"),
          StockCard(symbol: "TSLA", companyName: "Tesla, Inc.", price: 354.4322, changePercentage: 2.333, isPositive: true),
          StockCard(symbol: "TSLA", companyName: "Tesla, Inc.", price: 354.4322, changePercentage: 2.333, isPositive: true),
        ],

      ),
    );
  }

}