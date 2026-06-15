import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/screens/stock_detail_screen.dart';
import '../widgets/section_title.dart';
import '../widgets/affected_stock_chip.dart';
import '../utils/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget{
  final String title;
  final String articleText;
  final String source;
  final String date;
  final String imageURL;
  final String articleUrl;

  const NewsDetailScreen({
    super.key,
    required this.title,
    required this.articleText,
    required this.source,
    required this.date,
    required this.imageURL,
    required this.articleUrl,
  });

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
              title.length <= 20
                  ? title
                  : "${title.substring(0, 20)}...",
              style: const TextStyle(
                color: AppColors.textPrimaryColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 220,
                    child: Image.network(
                      imageURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      source,
                      style: const TextStyle(
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                SectionTitle(title: "Affected Stocks"),

                SizedBox(height: 12),
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

            SizedBox(height: 24),

            Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

                Text(
                  articleText,
                  style: const TextStyle(
                    color: AppColors.textPrimaryColor,
                  ),
                ),

                const SizedBox(height: 24),

                InkWell(
                  borderRadius: BorderRadius.circular(32),
                  onTap: () async {
                    final uri = Uri.parse(articleUrl);

                    await launchUrl(
                      uri,
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: AppColors.glassButtonDecoration,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Read Full Article",
                          style: TextStyle(
                            color: AppColors.textPrimaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(width: 8),

                        Icon(
                          Icons.north_east_rounded,
                          color: AppColors.textPrimaryColor,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
            ],
          ),
        ),
       ),
      );
    }

}