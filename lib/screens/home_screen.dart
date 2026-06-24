import 'package:flutter/material.dart';
import '../models/stock.dart';
import '../models/news_article.dart';
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
import '../services/service_locator.dart';
import '../screens/transaction_history_screen.dart';

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


  String firstName = "", surname = "";
  String selectedCountry = "TR";

  List<NewsArticle> trendingNews = [];
  bool isLoadingNews = true;

  List<Stock> trendingStocks = [];
  bool isLoadingStocks = true;

  List<Map<String, dynamic>> recentTransactions = [];
  bool isLoadingTransactions = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
    loadNews();
    loadStocks();
    loadRecentTransactions();
  }

  Future<void> loadUserData() async {
    final user = authService.currentUser;

    if(user == null) return;

    final data = await userService.getCurrentUserData(user.uid);

    if(data == null) return;

    final loadedCountry =
        data["selectedCountry"] ?? "US";

    marketService.setMarket(loadedCountry);

    if(!mounted) return;

    setState(() {
      firstName = data["firstName"] ?? "";
      surname = data["surname"] ?? "";
      selectedCountry = loadedCountry;
    });
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
      final List<Stock> loadedStocks = [];

      for (final symbol in marketService.marketSymbols.take(3)) {
        final stock = await _stockService.getStockQuote(symbol);
        loadedStocks.add(stock);
      }

      if (!mounted) return;

      setState(() {
        trendingStocks = loadedStocks;
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

  Future<void> loadRecentTransactions() async {
    final user = authService.currentUser;

    if (user == null) {
      return;
    }

    try {
      final loadedTransactions =
      await userService.getTransactions(
        uid: user.uid,
      );

      if (!mounted) return;

      setState(() {
        recentTransactions =
            loadedTransactions.take(5).toList();

        isLoadingTransactions = false;
      });
    } catch (e) {
      print(e);

      if (!mounted) return;

      setState(() {
        isLoadingTransactions = false;
      });
    }
  }

  final Map<String, String>countries = {
    "DE": "Germany",
    "US": "United States",
    "GB": "United Kingdom",
    "TR": "Turkey",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title: Image.asset(
            "lib/assets/login_logo.png",
            height: 30,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SizedBox(
                width: 75,
                height: 40,
                child: CountrySelector(
                  selectedCountry: selectedCountry,
                  countries: countries,
                  onChanged: (country) async {
                    if (country == null) return;

                    final user = authService.currentUser;
                    if (user == null) return;

                    setState(() {
                      selectedCountry = country;
                      isLoadingStocks = true;
                    });

                    marketService.setMarket(country);

                    await userService.updateSelectedCountry(
                      uid: user.uid,
                      countryCode: country,
                    );

                    await loadStocks();
                  },
                ),
              ),
            ),
          ],
        ),
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

              const SizedBox(height: 24),

              SectionTitle(title: "Recent Transactions"),

              if (isLoadingTransactions)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else if (recentTransactions.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    "No transactions yet",
                    style: TextStyle(
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: recentTransactions.map((transaction) {

                      final type =
                          transaction["type"] ?? "";
                      final symbol =
                          transaction["symbol"] ?? "";
                      final quantity =
                          transaction["quantity"] ?? 0;
                      final price =
                          transaction["price"] ?? 0;
                      final createdAt =
                      transaction["createdAt"];

                      return QuickOverviewCard(
                        type: type,
                        symbol: symbol,
                        quantity: (quantity as num).toDouble(),
                        price: (price as num).toDouble(),
                        createdAt: createdAt,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TransactionHistoryScreen(),
                            ),
                          );
                        },
                      );
                    }).toList(),
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
                            description: news.description,
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

              SizedBox(height: 60),
            ],
          ),
        ),
      )
    );
  }

}