import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/utils/app_theme.dart';

class NewsCard extends StatelessWidget {
  /*
  newsCard for home and news screens to list news as cards,
  card shows: title of news, description(shorter version of article)
  image of news, date of the news publish,
  and card is clickable but interaction handled in screens with onTap
   */
  final String title;
  final String description;
  final String imageURL;
  final String date;
  final VoidCallback onTap;

  const NewsCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageURL,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 130,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: AppColors.glassCardDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: SizedBox(
                width: 120,
                child: Image.network(
                  imageURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textPrimaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textSecondaryColor,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      date,
                      style: const TextStyle(
                        color: AppColors.textSecondaryColor,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}