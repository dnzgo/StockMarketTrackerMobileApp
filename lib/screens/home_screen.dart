import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/widgets/stock_card.dart';
import 'package:stock_market_tracker_mobile_app/widgets/section_title.dart';
import 'package:stock_market_tracker_mobile_app/widgets/quick_overview_card.dart';

import '../widgets/news_card.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome back,"),
                      Text("Deniz Gözcü")
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person_outline),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 16),
              SectionTitle(title: "Quick Overview"),
              SizedBox(height: 0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    QuickOverviewCard(marketName: "NASDAQ", marketValue: 2323.22, changePercentage: 2.50),
                    QuickOverviewCard(marketName: "NASDAQ", marketValue: 2323.22, changePercentage: 2.50),
                    QuickOverviewCard(marketName: "NASDAQ", marketValue: 2323.22, changePercentage: 2.50),
                    QuickOverviewCard(marketName: "NASDAQ", marketValue: 2323.22, changePercentage: 2.50),
                    QuickOverviewCard(marketName: "NASDAQ", marketValue: 2323.22, changePercentage: 2.50),
                    QuickOverviewCard(marketName: "NASDAQ", marketValue: 2323.22, changePercentage: 2.50),
                  ],
                ),
              ),
              SectionTitle(title: "Hot Stocks", actionText: "See all"),
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
              SectionTitle(title: "Hot News", actionText: "See all"),
              NewsCard(
                title: "Apple unveils new AI-powered devices",
                description:
                "Apple introduced new AI features for its devices.",
                imageUrl:
                "https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=800",
                time: "4h ago",
              ),
              NewsCard(
                title: "Apple unveils new AI-powered devices",
                description:
                "Apple introduced new AI features for its devices.",
                imageUrl:
                "https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=800",
                time: "4h ago",
              ),
            ],
          ),
        ),
      )
    );
  }

}