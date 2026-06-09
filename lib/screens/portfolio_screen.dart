import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/widgets/holding_card.dart';
import '../services/service_locator.dart';
import '../widgets/portfolio_summary_card.dart';
import '../widgets/section_title.dart';
import '../widgets/holding_card.dart';
import '../screens/stock_detail_screen.dart';
import '../utils/app_theme.dart';

class PortfolioScreen extends StatefulWidget{
  const PortfolioScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PortfolioState();
}
class _PortfolioState extends State<PortfolioScreen> {
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
              ),
              SizedBox(height: 12,),
              SectionTitle(title: "Holdings"),
              SizedBox(height: 8,),

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

            ],
          ),
        )
      )
    );
  }

}