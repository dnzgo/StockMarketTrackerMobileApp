import '../models/portfolio_holding.dart';
import '../models/stock.dart';

class PortfolioService {

  // private user cash balance
  double _cashBalance = 10000;

  // trading fee percentage = 0.1%
  static const double tradingFeeRate = 0.001;

  // public read only access to user cash balance
  double get cashBalance => _cashBalance;

  // private portfolio holdings list
  final List<PortfolioHolding> _holdings = [];

  // public read only access to portfolio holdings
  List<PortfolioHolding> get holdings => _holdings;

  void buyStock({
    required Stock stock,
    required double quantity,
  }) {
    // find existing holding for the stock symbol
    final existingIndex = _holdings.indexWhere(
        (holdings) => holdings.stock.symbol == stock.symbol,
    );

    // calculate new buy cost
    final stockCost = quantity * stock.price;
    final tradingFee = stockCost * tradingFeeRate;
    final totalBuyCost = stockCost + tradingFee;

    // if user does not have enough cash to buy
    if (totalBuyCost > _cashBalance) {
      return;
    }

    // if user has enough cash to buy then subtract cost from balance
    _cashBalance -= totalBuyCost;

    // if stock is not in portfolio add it as a new holding
    if (existingIndex == -1) {
      _holdings.add(
        PortfolioHolding(
          stock: stock,
          quantity: quantity,
          averageBuyPrice: stock.price,
        ),
      );
      return;
    }

    // get existing holding to update its quantity and averageBuyPrice
    final existingHolding = _holdings[existingIndex];
    // existing total cost before this buy
    final oldTotalCost = existingHolding.totalCost;

    // total quantity after buy
    final newQuantity = existingHolding.quantity + quantity;
    // calculate weighted average buy price after this buy
    final newAverageBuyPrice = (oldTotalCost + stockCost) / newQuantity;

    // change old immutable holding with updated holding
    _holdings[existingIndex] = PortfolioHolding(
      stock: stock,
      quantity: newQuantity,
      averageBuyPrice: newAverageBuyPrice,
    );

  }

  void sellStock({
    required Stock stock,
    required double quantity,
  }) {
    // find existing holding for the stock symbol
    final existingIndex = _holdings.indexWhere(
          (holdings) => holdings.stock.symbol == stock.symbol,
    );

    // if stock is not in portfolio or user tries to sell more than owned quantity
    if (existingIndex == -1 || quantity > _holdings[existingIndex].quantity) {
      return;
    }

    // get existing holding to update its quantity
    final existingHolding = _holdings[existingIndex];
    // remaining quantity after sell
    final newQuantity = existingHolding.quantity - quantity;

    // add sell value to cash balance
    final stockValue = quantity * stock.price;
    final tradingFee = stockValue * tradingFeeRate;
    final totalSellValue = stockValue - tradingFee;

    _cashBalance += totalSellValue;

    // if sold all then remove stock from holdings list
    if (newQuantity <= 0) {
      _holdings.removeAt(existingIndex);
      return;
    }

    // change old immutable holding with updated holding
    _holdings[existingIndex] = PortfolioHolding(
      stock: stock,
      quantity: newQuantity,
      averageBuyPrice: existingHolding.averageBuyPrice,
    );

  }

  PortfolioHolding? getHoldingBySymbol(String symbol) {
    try {
      return _holdings.firstWhere(
            (holding) => holding.stock.symbol == symbol,
      );
    } catch (e) {
      return null;
    }
  }

  bool hasStock(String symbol) {
    return getHoldingBySymbol(symbol) != null;
  }

  double getOwnedQuantity(String symbol) {
    final holding = getHoldingBySymbol(symbol);

    if (holding == null) {
      return 0;
    }

    return holding.quantity;
  }

}