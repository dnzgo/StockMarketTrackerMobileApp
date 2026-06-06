import 'package:flutter/material.dart';
import '../widgets/portfolio_summary_card.dart';
import '../widgets/section_title.dart';
import '../widgets/stock_card.dart';
import '../screens/stock_detail_screen.dart';

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
        title: Text("Portfolio"),
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
              StockCard(
                symbol: "TSLA",
                companyName: "Tesla Inc.",
                price: 321.333,
                changePercentage: -1.2,
                isPositive: false,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StockDetailScreen(
                            symbol: "TSLA",
                            companyName: "Tesla Inc.",
                            price: 321.333,
                            changePercentage: -1.2,
                            isPositive: false,
                          )
                      )
                  );
                },
              ),
              StockCard(
                symbol: "TSLA",
                companyName: "Tesla Inc.",
                price: 321.333,
                changePercentage: -1.2,
                isPositive: false,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StockDetailScreen(
                            symbol: "TSLA",
                            companyName: "Tesla Inc.",
                            price: 321.333,
                            changePercentage: -1.2,
                            isPositive: false,
                          )
                      )
                  );
                },
              ),
              StockCard(
                symbol: "TSLA",
                companyName: "Tesla Inc.",
                price: 321.333,
                changePercentage: -1.2,
                isPositive: false,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StockDetailScreen(
                            symbol: "TSLA",
                            companyName: "Tesla Inc.",
                            price: 321.333,
                            changePercentage: -1.2,
                            isPositive: false,
                          )
                      )
                  );
                },
              ),
            ],
          ),
        )
      )
    );
  }

}