import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../screens/news_detail_screen.dart';
import '../widgets/news_card.dart';
import '../widgets/search_bar.dart';
import '../utils/app_theme.dart';

class NewsExploreScreen extends StatefulWidget {

  final String initialCategory;

  const NewsExploreScreen({
    super.key,
    this.initialCategory = "All",
  });

  @override
  State<NewsExploreScreen> createState() => _NewsExploreState();
}

class _NewsExploreState extends State<NewsExploreScreen> {

  late String selectedCategory;
  String searchText = "";

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

  // filtered news list based on search text
  List<NewsArticle> get filteredNews {
    final query = searchText.toLowerCase();
    return latestNews.where((news) {
      return news.title.toLowerCase().contains(query) ||
          news.description.toLowerCase().contains(query) ||
          news.source.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
  }

  @override
  void didUpdateWidget(covariant NewsExploreScreen oldWidget) {
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
                      color: AppColors.textPrimaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SearchBarWidget(
                    hintText: "Search News...",
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
                    ...filteredNews.map((news) {
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