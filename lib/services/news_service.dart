/*
fetch trending/latest news
fetch stock-related news
convert JSON → NewsArticle model
filter news by category
*/

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/news_article.dart';

class NewsService {

  static final String apiKey = dotenv.env["NEWS_API_KEY"]!;

  Future<void> testConnection() async {

    final response = await http.get(
      Uri.parse(
        "https://finnhub.io/api/v1/news?category=general&token=$apiKey",
      ),
    );

    print("Status Code: ${response.statusCode}");
    print(response.body);
  }

  Future<List<NewsArticle>> getLatestNews({
    String category = "general",
  }) async {

    final response = await http.get(
      Uri.parse(
        "https://finnhub.io/api/v1/news?category=$category&token=$apiKey",
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load news");
    }

    final List<dynamic> jsonData =
    jsonDecode(response.body);

    return jsonData.take(20).map((news) {
      return NewsArticle(
        title: news["headline"] ?? "No Title",
        description:
        news["summary"] ?? "No Description",
        imageURL: news["image"] ?? "",
        source: news["source"] ?? "Unknown",
        date: DateFormat("dd MMM yyyy").format(
          DateTime.fromMillisecondsSinceEpoch(
            ((news["datetime"] ?? 0) as int) * 1000,
          ),
        ),
        articleUrl: news["url"] ?? "",
      );
    }).toList();
  }
}