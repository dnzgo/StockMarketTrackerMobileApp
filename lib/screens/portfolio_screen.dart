import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/service_locator.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../services/stock_service.dart';
import '../models/portfolio_holding.dart';
import '../widgets/holding_card.dart';
import '../widgets/portfolio_summary_card.dart';
import '../widgets/section_title.dart';
import '../widgets/cash_balance_card.dart';
import '../screens/stock_detail_screen.dart';
import '../screens/transaction_history_screen.dart';
import '../utils/app_theme.dart';

class PortfolioScreen extends StatefulWidget{
  const PortfolioScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PortfolioState();
}
class _PortfolioState extends State<PortfolioScreen> {

  final authService = AuthService();
  final userService = UserService();
  final stockService = StockService();

  List<FlSpot> portfolioChartSpots = [];

  Future<void> loadPortfolioData() async {
    final user = authService.currentUser;

    if (user == null) {
      return;
    }

    final data =
    await userService.getCurrentUserData(user.uid);

    if (data == null) {
      return;
    }

    final loadedCashBalance =
    (data["cashBalance"] ?? 0).toDouble();

    portfolioService.setCashBalance(loadedCashBalance);

    final transactions =
    await userService.getTransactions(uid: user.uid);
    final loadedHoldings = await userService.getHoldings(uid: user.uid);

    final currentHoldingSymbols =
    loadedHoldings.map((holding) => holding.stock.symbol).toSet();

    final chartSpots =
    await portfolioChartService.buildPortfolioChart(
      transactions: transactions,
      currentHoldingSymbols: currentHoldingSymbols,
    );

    portfolioChartSpots = chartSpots;


    final List<PortfolioHolding> liveHoldings = [];

    for (final holding in loadedHoldings) {
      final liveStock =
      await stockService.getStockQuote(
        holding.stock.symbol,
      );

      liveHoldings.add(
        PortfolioHolding(
          stock: liveStock,
          quantity: holding.quantity,
          averageBuyPrice:
          holding.averageBuyPrice,
        ),
      );
    }

    portfolioService.setHoldings(liveHoldings);

    if (!mounted) return;

    setState(() {}); // rebuild ui
  }

  @override
  void initState() {
    super.initState();
    loadPortfolioData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          "Portfolio",
          style: TextStyle(
            color: AppColors.textPrimaryColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.history,
              color: AppColors.textPrimaryColor,
              size: 28,
            ),
            tooltip: "Transaction History",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TransactionHistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PortfolioSummaryCard(
                totalValue: portfolioService.totalBalance,
                totalPnL: portfolioService.totalPnL,
                totalPnLPercentage: portfolioService.totalPnLPercentage,
                isPositive: portfolioService.isPositive,
                chartSpots: portfolioChartSpots,
              ),

              SizedBox(height: 12,),

              SectionTitle(title: "Holdings"),
              SizedBox(height: 8,),

              CashBalanceCard(
                cashType: "EURO",
                value: portfolioService.cashBalance,
              ),

              ...portfolioService.holdings.map((holding) {
                return HoldingCard(
                  holding: holding,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StockDetailScreen(
                          symbol: holding.stock.symbol,
                          companyName: holding.stock.companyName,
                          price: holding.stock.price,
                          changePercentage:
                          holding.stock.changePercentage,
                          isPositive:
                          holding.stock.changePercentage >= 0,
                        ),
                      ),
                    );
                    setState(() {});
                  },
                );
              }).toList(),
              const SizedBox(height: 60)
            ],
          ),
        )
      )
    );
  }

}