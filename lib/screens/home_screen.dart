import 'package:flutter/material.dart';
import '../models/stock.dart';
import '../models/news_article.dart';
import '../widgets/stock_card.dart';
import '../widgets/section_title.dart';
import '../widgets/quick_overview_card.dart';
import '../screens/stock_detail_screen.dart';
import '../screens/news_detail_screen.dart';
import '../utils/app_theme.dart';

import '../widgets/news_card.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}
class _HomeScreenState extends State<HomeScreen> {

  final List<Stock> trendingStocks = [
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

  final List<NewsArticle> trendingNews = [
    NewsArticle(
      title: "Apple unveils new AI-powered devices",
      description: "Apple introduced new AI features.",
      articleText: "Full article text here...",
      imageURL: "https://...",
      source: "Reuters",
      date: "June 6, 2026",
    ),

    NewsArticle(
      title: "Tesla stock jumps after strong earnings",
      description: "Tesla shares surged after earnings.",
      articleText: "Full article text here...",
      imageURL: "https://...",
      source: "Bloomberg",
      date: "June 5, 2026",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back,",
                          style: const TextStyle(
                            color: AppColors.textPrimaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "Deniz Gözcü",
                          style: const TextStyle(
                            color: AppColors.textPrimaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    CircleAvatar(
                      radius: 30,
                      child: Icon(
                        Icons.person_outline,
                        size: 45,
                      ),
                    ),
                  ],
                ),
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

              ...trendingStocks.map((stock) {
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
              }).toList(),

              SectionTitle(title: "Trending News", actionText: "See all"),

              ...trendingNews.map((news) {
                return NewsCard(
                  title: news.title,
                  description: news.description,
                  imageURL: news.imageURL,
                  date: news.date,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(
                            title: news.title,
                            articleText: news.articleText,
                            source: news.source,
                            date: news.date,
                            imageURL: news.imageURL,
                        )
                      ),
                    );
                  },
                );
              }).toList(),
            ],
          ),
        ),
      )
    );
  }

}