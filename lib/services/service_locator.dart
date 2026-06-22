import '../services/portfolio_service.dart';
import '../services/portfolio_chart_service.dart';
import '../services/stock_service.dart';
import '../services/currency_service.dart';
import '../services/market_service.dart';

/* shared portfolio service instance for whole app
  to shared use,
 */
final portfolioService = PortfolioService();
final stockService = StockService();
final marketService = MarketService();
final currencyService = CurrencyService();

final portfolioChartService =
PortfolioChartService(
  stockService: stockService,
);