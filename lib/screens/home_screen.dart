import 'package:flutter/material.dart';
import '../models/stock.dart';
import '../models/news_article.dart';
import '../models/market_index.dart';
import '../services/location_service.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../widgets/stock_card.dart';
import '../widgets/news_card.dart';
import '../widgets/section_title.dart';
import '../widgets/quick_overview_card.dart';
import '../widgets/country_selector.dart';
import '../screens/stock_detail_screen.dart';
import '../screens/news_detail_screen.dart';
import '../utils/app_theme.dart';
import '../utils/string_formatter.dart';
import '../services/news_service.dart';
import '../services/stock_service.dart';
import '../services/market_service.dart';

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
  final authService = AuthService();
  final userService = UserService();
  final _newsService = NewsService();
  final StockService _stockService = StockService();
  final MarketService _marketService = MarketService();


  String firstName = "", surname = "";
  String selectedCountry = "TR";

  List<NewsArticle> trendingNews = [];
  bool isLoadingNews = true;

  List<Stock> trendingStocks = [];
  bool isLoadingStocks = true;

  @override
  void initState() {
    super.initState();
    loadCountry();
    loadUserData();
    loadNews();
    loadStocks();
    loadIndexes();
  }

  Future<void> loadUserData() async {
    final user = authService.currentUser;

    if(user == null) return;

    final data = await userService.getCurrentUserData(user.uid);

    if(data == null) return;

    if(!mounted) return;

    setState(() {
      firstName = data["firstName"] ?? "";
      surname = data["surname"] ?? "";
    });
  }

  Future<void> loadCountry() async {
    final countryCode = await LocationService.getCountry();

    if (countryCode != null && countries.containsKey(countryCode)) {
      setState(() {
        selectedCountry = countryCode;
      });
    }
  }

  Future<void> loadNews() async {
    try {
      final news = await _newsService.getLatestNews();

      if (!mounted) return;

      setState(() {
        trendingNews = news;
        isLoadingNews = false;
      });
    } catch (e) {
      print(e);

      if (!mounted) return;

      setState(() {
        isLoadingNews = false;
      });
    }
  }

  Future<void> loadStocks() async {
    try {

      final tesla =
      await _stockService.getStockQuote(
        "TSLA",
        "Tesla Inc.",
      );

      final nvidia =
      await _stockService.getStockQuote(
        "NVDA",
        "NVIDIA",
      );

      final apple =
      await _stockService.getStockQuote(
        "AAPL",
        "Apple",
      );

      if (!mounted) return;

      setState(() {
        trendingStocks = [
          tesla,
          nvidia,
          apple,
        ];

        isLoadingStocks = false;
      });

    } catch (e) {

      print(e);

      if (!mounted) return;

      setState(() {
        isLoadingStocks = false;
      });
    }
  }

  Future<void> loadIndexes() async {
    try {

      final nasdaq =
      await _marketService.getIndex(
        "IXIC",
        "NASDAQ",
      );

      final sp500 =
      await _marketService.getIndex(
        "GSPC",
        "S&P 500",
      );

      final dax =
      await _marketService.getIndex(
        "GDAXI",
        "DAX",
      );

      final ftse =
      await _marketService.getIndex(
        "FTSE",
        "FTSE 100",
      );

      if (!mounted) return;

      setState(() {
        marketIndexes = [
          nasdaq,
          sp500,
          dax,
          ftse,
        ];

        isLoadingIndexes = false;
      });

    } catch (e) {

      print(e);

      if (!mounted) return;

      setState(() {
        isLoadingIndexes = false;
      });
    }
  }

  final Map<String, String>countries = {
    "DE": "Germany",
    "US": "United States",
    "GB": "United Kingdom",
    "TR": "Turkey",
  };

  List<MarketIndex> marketIndexes = [];
  bool isLoadingIndexes = true;

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
                          "${StringFormatter.toTitleCase(firstName)} ${StringFormatter.toTitleCase(surname)}",
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

              if (isLoadingIndexes)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...marketIndexes.map((index) {
                        return QuickOverviewCard(
                          marketName: index.name,
                          marketValue: index.value,
                          changePercentage: index.changePercentage,
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

              if (isLoadingStocks)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
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

              if (isLoadingNews)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
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
                            articleUrl: news.articleUrl,
                          ),
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