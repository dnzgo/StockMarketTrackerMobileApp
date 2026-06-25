/*
fetch trending stocks
fetch stock detail
fetch stock chart data
search stocks
convert JSON → Stock model
cache data ??
 */

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import '../services/service_locator.dart';
import '../models/stock.dart';
import '../models/stock_statistic.dart';

class StockService {

  static final String apiKey = dotenv.env["TWELVE_DATA_API_KEY"]!;

  Future<Stock> getStockQuote(
      String symbol,
      ) async {

    final response = await http.get(
      Uri.parse(
        "https://api.twelvedata.com/quote?symbol=$symbol&apikey=$apiKey",
      ),
    );

    if (response.statusCode != 200) {
      print("Quote failed for $symbol:");
      print(response.body);
      throw Exception("Failed to load stock");
    }

    final data = jsonDecode(response.body);

    final currentPrice =
        double.tryParse(
            data["price"]?.toString() ??
            data["close"]?.toString() ??
            "0",
        ) ?? 0;

    final changePercentage =
        double.tryParse(data["percent_change"]?.toString() ?? "0") ?? 0;

    return Stock(
      symbol: symbol,
      companyName: data["name"] ?? symbol,
      price: currencyService.convertFromBase(currentPrice),
      changePercentage: changePercentage,
    );
  }

  Future<StockStatistic> getStockStatistics(
      String symbol,
      ) async {

    final response = await http.get(
      Uri.parse(
        "https://api.twelvedata.com/quote?symbol=$symbol&apikey=$apiKey",
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load stock statistics");
    }

    final data = jsonDecode(response.body);
    print("Volume: ${data["volume"]}");

    return StockStatistic(
      open: currencyService.convertFromBase(
        double.tryParse(
          data["open"]?.toString() ?? "0",
        ) ?? 0,
      ),

      high: currencyService.convertFromBase(
        double.tryParse(
          data["high"]?.toString() ?? "0",
        ) ?? 0,
      ),

      low: currencyService.convertFromBase(
        double.tryParse(
          data["low"]?.toString() ?? "0",
        ) ?? 0,
      ),

      volume: double.tryParse(
        data["volume"]?.toString() ?? "0",
      ) ?? 0,
    );
  }

  Future<List<Stock>> getTrendingStocks() async {
    // fake trending list for now
    final symbols = marketService.marketSymbols;

    final List<Stock> trendingStocks = [];

    for (final symbol in symbols) {
      try {
        final stock =
        await getStockQuote(
          symbol,
        );

        trendingStocks.add(stock);
      } catch (e) {
        print(
          "Failed to load $symbol: $e",
        );
      }
    }

    return trendingStocks;
  }

  Future<List<FlSpot>> getChartData(
      String symbol,
      String period,
      ) async {

    String interval = "1h";
    int outputSize = 24;

    switch (period) {
      case "1D":
        interval = "1h";
        outputSize = 24;
        break;
      case "1W":
        interval = "1day";
        outputSize = 7;
        break;
      case "1M":
        interval = "1day";
        outputSize = 30;
        break;
      case "3M":
        interval = "1week";
        outputSize = 12;
        break;
      case "1Y":
        interval = "1month";
        outputSize = 12;
        break;
      case "5Y":
        interval = "1month";
        outputSize = 60;
        break;
    }

    final response = await http.get(
      Uri.parse(
        "https://api.twelvedata.com/time_series"
            "?symbol=$symbol"
            "&interval=$interval"
            "&outputsize=$outputSize"
            "&apikey=$apiKey",
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load chart data");
    }

    final data = jsonDecode(response.body);

    final values = data["values"];

    if (values == null) {
      return [];
    }

    final reversedValues =
    List.from(values.reversed);

    return List.generate(
      reversedValues.length,
          (index) {
        final closePrice = currencyService.convertFromBase(
          double.tryParse(
            reversedValues[index]["close"]?.toString() ?? "0",
          ) ?? 0,
        );

        return FlSpot(
          index.toDouble(),
          closePrice,
        );
      },
    );
  }

  Future<List<double>> getHistoricalClosePrices({
    required String symbol,
    int outputSize = 5,
  }) async {
    final response = await http.get(
      Uri.parse(
        "https://api.twelvedata.com/time_series"
            "?symbol=$symbol"
            "&interval=1day"
            "&outputsize=$outputSize"
            "&apikey=$apiKey",
      ),
    );

    if (response.statusCode != 200) {
      print("Historical price failed for $symbol:");
      print(response.body);
      throw Exception("Failed to load historical prices");
    }

    final data = jsonDecode(response.body);

    if (data["status"] == "error") {
      print("Historical price API error for $symbol:");
      print(data["message"]);
      return [];
    }

    final values = data["values"];

    if (values == null) {
      return [];
    }

    final reversedValues = List.from(values.reversed);

    return reversedValues.map<double>((value) {
      final closePriceUsd = double.tryParse(
        value["close"]?.toString() ?? "0",
      ) ??
          0;

      return currencyService.convertFromBase(closePriceUsd);
    }).toList();
  }

  Future<List<Stock>> searchStocks(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    final response = await http.get(
      Uri.parse(
        "https://api.twelvedata.com/symbol_search"
            "?symbol=${query.trim()}"
            "&apikey=$apiKey",
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to search stocks");
    }

    final data = jsonDecode(response.body);
    final results = data["data"] ?? [];

    final List<Stock> searchedStocks = [];

    for (final item in results.take(1)) {
      try {
        final symbol = item["symbol"]?.toString();

        if (symbol == null) continue;

        final stock = await getStockQuote(symbol);
        searchedStocks.add(stock);
      } catch (e) {
        print("Failed to load searched stock: $e");
      }
    }

    return searchedStocks;
  }

}