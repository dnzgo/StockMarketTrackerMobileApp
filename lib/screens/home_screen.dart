import 'package:flutter/material.dart';
import '../widgets/stock_card.dart';
import '../widgets/section_title.dart';
import '../widgets/quick_overview_card.dart';
import '../screens/stock_detail_screen.dart';
import '../screens/news_detail_screen.dart';

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
              SectionTitle(title: "Market Overview"),
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
              SectionTitle(title: "Trending Stocks", actionText: "See all"),
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
              SectionTitle(title: "Trending News", actionText: "See all"),
              NewsCard(
                title: "Apple unveils new AI-powered devices",
                description:
                "Apple introduced new AI features for its devices.",
                imageUrl:
                "https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=800",
                time: "4h ago",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(
                            title: "Apple launches new chip for apple AI",
                            articleText: "Full article text is here",
                            source: "Reuters",
                            date: "June 6, 2026",
                            imageURL: "",
                          )
                      )
                  );
                },
              ),
              NewsCard(
                title: "Tesla stock jumps after strong earnings",
                description:
                "Tesla shares surged after earnings report.",
                imageUrl:
                "https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=800",
                time: "2h ago",
                onTap: () {},
              ),
            ],
          ),
        ),
      )
    );
  }

}