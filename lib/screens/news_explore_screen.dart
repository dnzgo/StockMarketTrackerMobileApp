import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../screens/news_detail_screen.dart';
import '../widgets/news_card.dart';
import '../widgets/search_bar.dart';

class NewsExploreScreen extends StatefulWidget {
  const NewsExploreScreen({super.key});

  @override
  State<NewsExploreScreen> createState() => _NewsExploreState();
}

class _NewsExploreState extends State<NewsExploreScreen> {

  final List<NewsArticle> latestNews = [
    NewsArticle(
      title: "Apple unveils new AI-powered devices",
      description: "Apple introduced new AI features.",
      articleText: "Full article text here...",
      imageURL: "https://...",
      source: "Reuters",
      date: "June 6, 2026",
    ),

    NewsArticle(
      title: "Tesla stock jumps after strong earnings",
      description: "Tesla shares surged after earnings.",
      articleText: "Full article text here...",
      imageURL: "https://...",
      source: "Bloomberg",
      date: "June 5, 2026",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "News",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SearchBarWidget(
                    hintText: "Search News...",
                    onChanged: (text) {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...latestNews.map((news) {
                      return NewsCard(
                        title: news.title,
                        description: news.description,
                        imageURL: news.imageURL,
                        date: news.date,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsDetailScreen(
                                  title: news.title,
                                  articleText: news.articleText,
                                  source: news.source,
                                  date: news.date,
                                  imageURL: news.imageURL,
                                )
                            ),
                          );
                        },
                      );
                    }).toList(),
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