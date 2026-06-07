import '../models/portfolio_holding.dart';
import '../models/stock.dart';

class PortfolioService {

  // private user cash balance
  double _cashBalance = 10000;

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
    final newBuyCost = quantity * stock.price;

    // if user does not have enough cash to buy
    if (newBuyCost > _cashBalance) {
      return;
    }

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

    // if user has enough cash to buy then subtract cost from balance
    _cashBalance -= newBuyCost;

    // total quantity after buy
    final newQuantity = existingHolding.quantity + quantity;
    // calculate weighted average buy price after this buy
    final newAverageBuyPrice = (oldTotalCost + newBuyCost) / newQuantity;

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
    final totalSellValue = quantity * stock.price;
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

}