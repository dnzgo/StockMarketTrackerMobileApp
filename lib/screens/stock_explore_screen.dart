import 'package:flutter/material.dart';
import '../models/stock.dart';
import '../screens/stock_detail_screen.dart';
import '../widgets/stock_card.dart';
import '../widgets/search_bar.dart';
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

  late String selectedCategory;
  String searchText = "";

  final List<Stock> stocks = [
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

  // filtered stock list based on search text
  List<Stock> get filteredStocks {
    final query = searchText.toLowerCase();

    return stocks.where((stock) {
      return stock.symbol.toLowerCase().contains(query) ||
          stock.companyName.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
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
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // spread operator (...) used children expects individual widgets
                        // but stock.map returns a list spread operator unwraps the list items
                        // into children one by one
                        ...filteredStocks.map((stock) {
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
                        }).toList()
                      ],
                    ),
                  )
              )
            ],
      )
      )
    );
  }

}