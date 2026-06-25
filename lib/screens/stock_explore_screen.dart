import 'package:flutter/material.dart';
import 'dart:async';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../services/service_locator.dart';
import '../services/stock_service.dart';
import '../models/stock.dart';
import '../screens/stock_detail_screen.dart';
import '../widgets/stock_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_chip.dart';
import '../utils/app_theme.dart';

class StockExploreScreen extends StatefulWidget{
  final String initialCategory;

  const StockExploreScreen({
    super.key,
    this.initialCategory = "All",
  });

  @override
  State<StatefulWidget> createState() => _StockExploreState();
}
class _StockExploreState extends State<StockExploreScreen> {
  final authService = AuthService();
  final userService = UserService();
  final stockService = StockService();

  bool isSearching = false;
  Timer? searchDebounce;

  List<String> watchlistSymbols = [];

  List<Stock> stocks = [];
  bool isLoadingStocks = true;

  late String selectedCategory = "All";
  String searchText = "";

  // category list
  final List<String> categories = [
    "All",
    "Watchlist",
    "Trends",
    "Technology",
    "Energy",
    "Finance",
    "Crypto",
  ];

  Future<void> searchStocks(String text) async {
    setState(() {
      searchText = text;
    });

    if (text.trim().isEmpty) {
      setState(() {
        isSearching = false;
      });

      await loadStocks();
      return;
    }

    setState(() {
      isSearching = true;
    });

    try {
      final results = await stockService.searchStocks(text);

      if (!mounted) return;

      setState(() {
        stocks = results;
        isSearching = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isSearching = false;
      });
    }
  }

  // filtered stock list based on search text and category(for now mock)
  List<Stock> get filteredStocks {
    final query = searchText.toLowerCase();

    return stocks.where((stock) {
      final matchesSearch =
          stock.symbol.toLowerCase().contains(query) ||
              stock.companyName.toLowerCase().contains(query);

      final matchesCategory = matchesStockCategory(stock);

      return matchesSearch && matchesCategory;
    }).toList();
  }

  bool matchesStockCategory(Stock stock) {
    final symbol = stock.symbol.toUpperCase();

    switch (selectedCategory) {
      case "All":
        return true;

      case "Watchlist":
        return watchlistSymbols.contains(stock.symbol);

      case "Trends":
        return true;

      case "Technology":
        return ["AAPL", "MSFT", "NVDA", "GOOGL", "META", "SAP",].contains(symbol);

      case "Energy":
        return ["XOM", "CVX", "BP",].contains(symbol);

      case "Finance":
        return ["JPM", "BAC", "GS", "MS", "GARAN", "AKBNK", "HSBA.L", "BARC.L",].contains(symbol);

      case "Crypto":
        return ["BTC/USD", "ETH/USD",].contains(symbol);

      default:
        return true;
    }
  }

  Future<void> loadWatchlist() async {
    final user = authService.currentUser;

    if(user == null) return;

    final loadedWatchlist = await userService.getWatchlist(uid: user.uid);

    if(!mounted) return;

    setState(() {
      watchlistSymbols = loadedWatchlist;
    });
  }

  Future<void> loadStocks() async {
    setState(() {
      isLoadingStocks = true;
    });

    final loadedStocks = <Stock>[];

    for (final symbol in marketService.marketSymbols) {
      try {
        final stock = await stockService.getStockQuote(symbol);
        loadedStocks.add(stock);
      } catch (e) {
        print("Skipping $symbol: $e");
      }
    }

    if (!mounted) return;

    setState(() {
      stocks = loadedStocks;
      isLoadingStocks = false;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
    loadWatchlist();
    loadStocks();
  }

  @override
  void didUpdateWidget(covariant StockExploreScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialCategory != widget.initialCategory) {
      selectedCategory = widget.initialCategory;
    }
  }

  @override
  void dispose() {
    searchDebounce?.cancel();
    super.dispose();
  }

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
                        color: AppColors.textPrimaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    SearchBarWidget(
                      hintText: "Search Stocks...",
                      onChanged: (text) {
                        searchDebounce?.cancel();

                        searchDebounce = Timer(
                          const Duration(milliseconds: 1000),
                              () {
                            searchStocks(text);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...categories.map((category) {
                            return CategoryChip(
                              title: category,
                              isSelected: selectedCategory == category,
                              onTap: () async {
                                setState(() {
                                  selectedCategory = category;
                                });
                                if (category == "Watchlist") {
                                  await loadWatchlist();
                                }
                              },
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // show loading indicator while stocks are being fetched
                      if (isLoadingStocks || isSearching)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32),
                            child: CircularProgressIndicator(),
                          ),
                        )

                      // watchlist empty state
                      else if (
                      selectedCategory == "Watchlist" &&
                          filteredStocks.isEmpty
                      )
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(32),
                          decoration:
                          AppColors.glassCardDecoration,
                          child: const Column(
                            children: [
                              Icon(
                                Icons.star_border,
                                size: 48,
                                color:
                                AppColors.textSecondaryColor,
                              ),

                              SizedBox(height: 12),

                              Text(
                                "No watchlist stocks yet",
                                style: TextStyle(
                                  color:
                                  AppColors.textPrimaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 8),

                              Text(
                                "Add stocks by tapping the star icon.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                  AppColors.textSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        )

                      // no stocks found
                      else if (filteredStocks.isEmpty)
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.all(32),
                            decoration: AppColors.glassCardDecoration,
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 48,
                                  color: AppColors.textSecondaryColor,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "No stocks found",
                                  style: TextStyle(
                                    color: AppColors.textPrimaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Try another company name or symbol.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.textSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          )

                      // stock list
                      else
                        ...filteredStocks.map((stock) {
                          return StockCard(
                            symbol: stock.symbol,
                            companyName: stock.companyName,
                            price: stock.price,
                            changePercentage:
                            stock.changePercentage,
                            isPositive:
                            stock.isPositive,
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StockDetailScreen(
                                        symbol: stock.symbol,
                                        companyName:
                                        stock.companyName,
                                        price: stock.price,
                                        changePercentage:
                                        stock.changePercentage,
                                        isPositive:
                                        stock.isPositive,
                                      ),
                                ),
                              );

                              await loadWatchlist();
                            },
                          );
                        }).toList(),
                      const SizedBox(height: 60)
                    ],
                  ),
                ),
              )
            ],
      )
      )
    );
  }

}