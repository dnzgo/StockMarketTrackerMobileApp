/*
fetch market indexes
fetch index detail
fetch market overview data

convert JSON → MarketIndex model

supported indexes:
NASDAQ
S&P 500
DAX
FTSE 100

cache data ??
*/

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/market_index.dart';

class MarketService {

  static const String apiKey =
      "c19e44d534624e31976412c88233556c";

  Future<MarketIndex> getIndex(
      String symbol,
      String name,
      ) async {

    final response = await http.get(
      Uri.parse(
        "https://api.twelvedata.com/quote?symbol=$symbol&apikey=$apiKey",
      ),
    );

    final data = jsonDecode(response.body);

    print(data);

    return MarketIndex(
      name: name,
      value: double.tryParse(
        data["close"]?.toString() ?? "0",
      ) ?? 0,
      changePercentage: double.tryParse(
        data["percent_change"]?.toString() ?? "0",
      ) ?? 0,
    );
  }
}