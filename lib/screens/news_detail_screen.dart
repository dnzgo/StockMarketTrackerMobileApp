import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/screens/stock_detail_screen.dart';
import '../widgets/section_title.dart';
import '../widgets/affected_stock_chip.dart';

class NewsDetailScreen extends StatelessWidget{
  final String title;
  final String articleText;
  final String source;
  final String date;
  final String imageURL;

  const NewsDetailScreen({
    super.key,
    required this.title,
    required this.articleText,
    required this.source,
    required this.date,
    required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title.length <= 20
              ? title
              : title.substring(0, 20) + "..."
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            SizedBox(height: 16,),
            Container( // container for image
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(source),
                Text(date),
              ],
            ),
            SizedBox(height: 24,),
            Text(articleText),
            SizedBox(height: 24,),
            SectionTitle(title: "Affected Stocks"),
            SizedBox(height: 12,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  AffectedStockChip(
                    symbol: "TSLA",
                    changePercentage: -1.2,
                    isPositive: false,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StockDetailScreen(
                            symbol: "TSLA",
                            companyName: "Tesla, Inc.",
                            price: 321.33,
                            changePercentage: -1.2,
                            isPositive: false,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 12),

                  AffectedStockChip(
                    symbol: "NVDA",
                    changePercentage: 2.4,
                    isPositive: true,
                    onTap: () {},
                  ),
                  SizedBox(width: 12),

                  AffectedStockChip(
                    symbol: "AAPL",
                    changePercentage: 0.8,
                    isPositive: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}