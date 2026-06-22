import 'package:flutter/material.dart';
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

  // filtered stock list based on search text and category(for now mock)
  List<Stock> get filteredStocks {
    final query = searchText.toLowerCase();

    return stocks.where((stock) {
      final matchesSearch =
          stock.symbol.toLowerCase().contains(query) ||
              stock.companyName.toLowerCase().contains(query);

      bool matchesCategory = false;

      if(selectedCategory == "All") {
        matchesCategory = true;
      } else if(selectedCategory == "Watchlist") {
        matchesCategory = watchlistSymbols.contains(stock.symbol);
      } else if(selectedCategory == "Trends") {
        matchesCategory = true;                  // temporary
      } else if(selectedCategory == "Technology") {
        matchesCategory = true;                  // temporary
      } else if(selectedCategory == "Energy") {
        matchesCategory = true;                  // temporary
      } else if(selectedCategory == "Finance") {
        matchesCategory = true;                  // temporary
      } else if(selectedCategory == "Crypto") {
        matchesCategory = true;                  // temporary
      }

      return matchesSearch && matchesCategory;
    }).toList();
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

    try {
      final loadedStocks = <Stock>[];

      for (final symbol in marketService.marketSymbols) {
        final stock = await stockService.getStockQuote(symbol);
        loadedStocks.add(stock);
      }

      if (!mounted) return;

      setState(() {
        stocks = loadedStocks;
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
                        setState(() {
                          searchText = text;
                        });
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
                                if (category == "watchlist") {
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
                      if (isLoadingStocks)
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