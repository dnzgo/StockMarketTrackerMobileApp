/*
fetch trending/latest news
fetch stock-related news
convert JSON → NewsArticle model
filter news by stock symbol
 */

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';
import 'package:intl/intl.dart';

class NewsService {

  static const String apiKey =
      "d8o4i31r01qvtr6mgik0d8o4i31r01qvtr6mgikg";

  Future<void> testConnection() async {

    final response = await http.get(
      Uri.parse(
        "https://finnhub.io/api/v1/news?category=general&token=$apiKey",
      ),
    );

    print("Status Code: ${response.statusCode}");
    print(response.body);
  }

  Future<List<NewsArticle>> getLatestNews() async {
    final response = await http.get(
      Uri.parse(
        "https://finnhub.io/api/v1/news?category=general&token=$apiKey",
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load news");
    }

    final List<dynamic> jsonData = jsonDecode(response.body);

    return jsonData.take(20).map((news) {
      return NewsArticle(
        title: news["headline"] ?? "No Title",
        description: news["summary"] ?? "No Description",
        articleText: news["summary"] ?? "",
        imageURL: news["image"] ?? "",
        source: news["source"] ?? "Unknown",
        date: DateFormat("dd MMM yyyy").format(
          DateTime.fromMillisecondsSinceEpoch(
            ((news["datetime"] ?? 0) as int) * 1000,
          ),
        ),
      );
    }).toList();
  }
}