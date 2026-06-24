import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../screens/news_detail_screen.dart';
import '../widgets/news_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_chip.dart';
import '../utils/app_theme.dart';
import '../services/news_service.dart';

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

  final NewsService _newsService = NewsService();

  List<NewsArticle> latestNews = [];
  bool isLoading = true;


  // category list
  final List<String> categories = [
    "All",
    "Crypto",
    "Markets",
    "Companies"
  ];

  // filtered news list based on search text
  List<NewsArticle> get filteredNews {
    final query = searchText.toLowerCase();
    return latestNews.where((news) {
      final matchesSearch =
        news.title.toLowerCase().contains(query) ||
          news.source.toLowerCase().contains(query) ||
          news.description.toLowerCase().contains(query);
      return matchesSearch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
    loadNews();
  }

  Future<void> loadNews({
    String category = "general",
  }) async {
    try {
      final news = await _newsService.getLatestNews(
        category: category,
      );

      if (!mounted) return;

      setState(() {
        latestNews = news;
        isLoading = false;
      });
    } catch (e) {
      print(e);

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
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
                  const SizedBox(height: 12),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...categories.map((category) {
                          return CategoryChip(
                            title: category,
                            isSelected: selectedCategory == category,
                            onTap: () async {

                              setState(() {
                                selectedCategory = category;
                                isLoading = true;
                              });

                              String apiCategory = "general";

                              if (category == "Crypto") {
                                apiCategory = "crypto";
                              }

                              if (category == "Markets") {
                                apiCategory = "forex";
                              }

                              if (category == "Companies") {
                                apiCategory = "merger";
                              }

                              await loadNews(
                                category: apiCategory,
                              );
                            },
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : SingleChildScrollView(
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
                                  description: news.description,
                                  source: news.source,
                                  date: news.date,
                                  imageURL: news.imageURL,
                                  articleUrl: news.articleUrl,
                                )
                            ),
                          );
                        },
                      );
                    }).toList(),
                    const SizedBox(height: 80)
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