import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../widgets/stock_chart_card.dart';
import '../widgets/stock_info_card.dart';
import '../screens/trade_screen.dart';
import '../utils/app_theme.dart';

class StockDetailScreen extends StatefulWidget {
  final String symbol;
  final String companyName;
  final double price;
  final double changePercentage;
  final bool isPositive;

  const StockDetailScreen({
    super.key,
    required this.symbol,
    required this.companyName,
    required this.price,
    required this.changePercentage,
    required this.isPositive,
  });

  @override
  State<StatefulWidget> createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetailScreen> {

  final authService = AuthService();
  final userService = UserService();

  bool isWatchlisted = false;

  Future<void> loadWatchlistStatus() async {
    final user = authService.currentUser;
    if(user == null) return;

    final watched = await userService.isWatchlisted(
        uid: user.uid,
        symbol: widget.symbol
    );

    if(!mounted) return;

    setState(() {
      isWatchlisted = watched;
    });
  }

  Future<void> toggleWatchlist() async{
    final user = authService.currentUser;
    if(user == null) return;

    if(isWatchlisted) {
      await userService.removeFromWatchlist(
          uid: user.uid,
          symbol: widget.symbol
      );
    } else {
      await userService.addToWatchlist(
          uid: user.uid,
          symbol: widget.symbol
      );
    }
    if(!mounted) return;

    setState(() {
      isWatchlisted = !isWatchlisted;
    });
  }

  @override
  void initState() {
    super.initState();
    loadWatchlistStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppColors.appBackground(
        center: Alignment.bottomRight,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: AppColors.textPrimaryColor,
          ),
          title: Text(
            widget.companyName,
            style: const TextStyle(
              color: AppColors.textPrimaryColor,
            ),
          ),
          actions: [
            IconButton(onPressed: toggleWatchlist, icon: Icon(
              isWatchlisted
                ? Icons.star
                : Icons.star_border,
              color: Colors.amber,
            ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.symbol,
                      style: const TextStyle(
                        color: AppColors.textPrimaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "€${widget.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: AppColors.textPrimaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${widget.changePercentage.toStringAsFixed(2)}%",
                          style: TextStyle(
                            color: widget.isPositive
                                ? AppColors.increasedValueColor
                                : AppColors.decreasedValueColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const StockChartCard(),

                const SizedBox(height: 24),

                const Text(
                  "Statistics",
                  style: TextStyle(
                    color: AppColors.textPrimaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: const Row(
                    children: [
                      StockInfoCard(
                        title: "Open",
                        value: 175.32,
                      ),
                      StockInfoCard(
                        title: "High",
                        value: 177.85,
                      ),
                      StockInfoCard(
                        title: "Low",
                        value: 134.20,
                      ),
                      StockInfoCard(
                        title: "Volume",
                        value: 52.34,
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TradeScreen(
                      symbol: widget.symbol,
                      companyName: widget.companyName,
                      price: widget.price,
                    ),
                  ),
                );
                setState(() {});
              },
              child: Container(
                height: 60,
                decoration: AppColors.glassButtonDecoration,
                child: Center(
                  child: Text(
                    "Trade ${widget.symbol}",
                    style: const TextStyle(
                      color: AppColors.textPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}