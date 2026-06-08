import 'package:flutter/material.dart';
import '../services/service_locator.dart';
import '../widgets/portfolio_summary_card.dart';
import '../widgets/section_title.dart';
import '../widgets/stock_card.dart';
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
                totalValue: 2000.53,
                totalPnL: -120.5,
                totalPnLPercentage: -5.3,
              ),
              SizedBox(height: 12,),
              SectionTitle(title: "Holdings"),
              SizedBox(height: 8,),

              ...portfolioService.holdings.map((holding) {
                return StockCard(
                  symbol: holding.stock.symbol,
                  companyName: holding.stock.companyName,
                  price: holding.stock.price,
                  changePercentage:
                  holding.stock.changePercentage,
                  isPositive:
                  holding.stock.changePercentage >= 0,
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