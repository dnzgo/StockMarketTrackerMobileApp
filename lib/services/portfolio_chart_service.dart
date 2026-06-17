import 'package:fl_chart/fl_chart.dart';
import '../models/portfolio_holding.dart';
import 'stock_service.dart';

// calculate portfolio chart from holdings + cash + historical prices
class PortfolioChartService {
  final StockService stockService;

  PortfolioChartService({
    required this.stockService,
  });

  Future<List<FlSpot>> buildPortfolioChartSpots({
    required List<PortfolioHolding> holdings,
    required double cashBalance,
  }) async {
    if (holdings.isEmpty) {
      return [
        FlSpot(0, cashBalance),
        FlSpot(1, cashBalance),
        FlSpot(2, cashBalance),
        FlSpot(3, cashBalance),
        FlSpot(4, cashBalance),
      ];
    }

    final List<List<double>> allPriceHistories = [];

    for (final holding in holdings) {
      final prices =
      await stockService.getHistoricalClosePrices(
        symbol: holding.stock.symbol,
        outputSize: 5,
      );

      allPriceHistories.add(prices);
    }

    final List<FlSpot> portfolioSpots = [];

    for (int i = 0; i < 5; i++) {
      double totalValue = cashBalance;

      for (int j = 0; j < holdings.length; j++) {
        final holding = holdings[j];
        final prices = allPriceHistories[j];

        if (i < prices.length) {
          totalValue +=
              holding.quantity * prices[i];
        }
      }

      portfolioSpots.add(
        FlSpot(i.toDouble(), totalValue),
      );
    }

    return portfolioSpots;
  }
}