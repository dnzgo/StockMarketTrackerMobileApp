import 'package:flutter/material.dart';
import '../models/stock.dart';
import '../models/news_article.dart';
import '../models/market_index.dart';
import '../services/location_service.dart';
import '../widgets/stock_card.dart';
import '../widgets/news_card.dart';
import '../widgets/section_title.dart';
import '../widgets/quick_overview_card.dart';
import '../widgets/country_selector.dart';
import '../screens/stock_detail_screen.dart';
import '../screens/news_detail_screen.dart';
import '../utils/app_theme.dart';

class HomeScreen extends StatefulWidget{

  final VoidCallback onSeeAllTrendingStocks;
  final VoidCallback onSeeAllTrendingNews;

  const HomeScreen({
    super.key,
    required this.onSeeAllTrendingStocks,
    required this.onSeeAllTrendingNews,
  });

  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}
class _HomeScreenState extends State<HomeScreen> {

  String selectedCountry = "TR";

  @override
  void initState() {
    super.initState();
    loadCountry();
  }

  Future<void> loadCountry() async {
    final countryCode = await LocationService.getCountry();

    if (countryCode != null && countries.containsKey(countryCode)) {
      setState(() {
        selectedCountry = countryCode;
      });
    }
  }

  final Map<String, String>countries = {
    "DE": "Germany",
    "US": "United States",
    "GB": "United Kingdom",
    "TR": "Turkey",
  };

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

  final List<MarketIndex> marketIndexes = [
    MarketIndex(
      name: "NASDAQ",
      value: 17650.43,
      changePercentage: 1.32,
    ),
    MarketIndex(
      name: "S&P 500",
      value: 5398.20,
      changePercentage: 0.84,
    ),
    MarketIndex(
      name: "DAX",
      value: 18902.54,
      changePercentage: -0.43,
    ),
    MarketIndex(
      name: "FTSE 100",
      value: 8273.11,
      changePercentage: 0.22,
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
            crossAxisAlignment: CrossAxisAlignment.start,
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

              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  top: 20,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 75,
                    height: 40,
                    child: CountrySelector(
                      selectedCountry: selectedCountry,
                      countries: countries,
                      onChanged: (country) {
                        setState(() {
                          selectedCountry = country!;
                        });
                      },
                    ),
                  ),
                ),
              ),

              SectionTitle(title: "Market Overview"),
              SizedBox(height: 0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...marketIndexes.map((index) {
                      return QuickOverviewCard(
                        marketName: index.name,
                        marketValue: index.value,
                        changePercentage:
                        index.changePercentage,
                      );
                    }).toList(),
                  ],
                ),
              ),
              SectionTitle(
                title: "Trending Stocks",
                actionText: "See all",
                onTap: widget.onSeeAllTrendingStocks,
              ),

              ...trendingStocks.take(3).map((stock) {
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

              SectionTitle(
                title: "Trending News",
                actionText: "See all",
                onTap: widget.onSeeAllTrendingNews,
              ),

              ...trendingNews.take(3).map((news) {
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

              SizedBox(height: 60,),
            ],
          ),
        ),
      )
    );
  }

}