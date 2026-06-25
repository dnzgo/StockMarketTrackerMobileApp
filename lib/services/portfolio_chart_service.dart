import 'package:fl_chart/fl_chart.dart';
import '../models/transaction_record.dart';
import '../services/stock_service.dart';

class PortfolioChartService {
  final StockService stockService;

  PortfolioChartService({
    required this.stockService,
  });

  Future<List<FlSpot>> buildPortfolioChart({
    required List<TransactionRecord> transactions,
    required Set<String> currentHoldingSymbols,
    double initialCashBalance = 10000,
  }) async {
    final validTransactions = transactions
        .where((transaction) => transaction.createdAt != null)
        .toList();

    if (validTransactions.isEmpty) {
      return const [
        FlSpot(0, 10000),
        FlSpot(1, 10000),
        FlSpot(2, 10000),
        FlSpot(3, 10000),
        FlSpot(4, 10000),
      ];
    }

    validTransactions.sort(
          (a, b) => a.createdAt!.compareTo(b.createdAt!),
    );

    final startDate = validTransactions.first.createdAt!;
    final endDate = DateTime.now();
    final totalDays = endDate.difference(startDate).inDays;

    final chartDates = List.generate(5, (index) {
      if (totalDays == 0) {
        return startDate.add(
          Duration(minutes: index),
        );
      }

      final daysToAdd = ((totalDays / 4) * index).round();

      return startDate.add(
        Duration(days: daysToAdd),
      );
    });

    final symbols = validTransactions
        .map((transaction) => transaction.symbol)
        .where((symbol) => currentHoldingSymbols.contains(symbol))
        .toSet();

    final Map<String, List<double>> historicalPrices = {};

    for (final symbol in symbols) {
      try {
        historicalPrices[symbol] =
        await stockService.getHistoricalClosePrices(
          symbol: symbol,
          outputSize: 5,
        );
      } catch (e) {
        print("Skipping historical prices for $symbol: $e");
        historicalPrices[symbol] = [];
      }
    }

    final spots = <FlSpot>[];

    for (int i = 0; i < chartDates.length; i++) {
      final currentSpotDate = chartDates[i];

      double cashBalance = initialCashBalance;
      final quantities = <String, double>{};

      for (final transaction in validTransactions) {
        if (transaction.createdAt!.isAfter(currentSpotDate)) {
          continue;
        }

        final symbol = transaction.symbol;

        if (transaction.type == "deposit") {
          cashBalance += transaction.totalAmount;
        } else if (transaction.type == "buy") {
          cashBalance -= transaction.totalAmount;
          quantities[symbol] =
              (quantities[symbol] ?? 0) + transaction.quantity;
        } else if (transaction.type == "sell") {
          cashBalance += transaction.totalAmount;
          quantities[symbol] =
              (quantities[symbol] ?? 0) - transaction.quantity;
        }
      }

      double holdingsValue = 0;

      quantities.forEach((symbol, quantity) {
        final prices = historicalPrices[symbol] ?? [];

        if (quantity > 0 && i < prices.length) {
          holdingsValue += quantity * prices[i];
        }
      });

      final totalValue = cashBalance + holdingsValue;

      print("========== Spot $i ==========");
      print("Date: $currentSpotDate");
      print("Cash Balance: ${cashBalance.toStringAsFixed(2)}");

      quantities.forEach((symbol, quantity) {
        final prices = historicalPrices[symbol] ?? [];

        if (quantity > 0 && i < prices.length) {
          final value = quantity * prices[i];

          print(
            "$symbol | "
                "Qty: ${quantity.toStringAsFixed(2)} | "
                "Price: ${prices[i].toStringAsFixed(2)} | "
                "Value: ${value.toStringAsFixed(2)}",
          );
        }
      });

      print("Holdings Value: ${holdingsValue.toStringAsFixed(2)}");
      print("Portfolio Value: ${totalValue.toStringAsFixed(2)}");
      print("=============================");

      spots.add(
        FlSpot(
          i.toDouble(),
          totalValue,
        ),
      );
    }

    return spots;
  }
}