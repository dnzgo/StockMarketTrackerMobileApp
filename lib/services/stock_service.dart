/*
fetch trending stocks
fetch stock detail
fetch stock chart data
search stocks
convert JSON → Stock model
cache data ??
 */

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/stock.dart';

class StockService {

  static const String apiKey = "c19e44d534624e31976412c88233556c";

  Future<Stock> getStockQuote(
      String symbol,
      String companyName,
      ) async {

    final response = await http.get(
      Uri.parse(
        "https://api.twelvedata.com/quote?symbol=$symbol&apikey=$apiKey",
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load stock");
    }

    final data = jsonDecode(response.body);

    final currentPrice =
        double.tryParse(data["close"]?.toString() ?? "0") ?? 0;

    final changePercentage =
        double.tryParse(data["percent_change"]?.toString() ?? "0") ?? 0;

    return Stock(
      symbol: symbol,
      companyName: data["name"] ?? companyName,
      price: currentPrice,
      changePercentage: changePercentage,
    );
  }
}