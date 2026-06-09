import '../models/portfolio_holding.dart';
import '../models/stock.dart';

class PortfolioService {
  /*
  Portfolio service is for portfolio management:
  cash balance for users cash in this app,
  trading fee rate to calculate fees and every buy / sell
  substructs fee from cash balance but does not effect the average buy price of the stock and PnL
  list of holdings that saves the stock holdings and a getter to access holdings list
  buyStock function: this function handles stock buy, if user already have that stock, finds the stock in holdings list and updates,
  if stock is not in the list it adds it, also checks if user have enough cash to buy.
  sellStock function: this function handles stock sell, checks if user have enough to sell and executes sell,
  if user sells all finds from holdings list then removes from holdings list,
  if sells a part of stock then finds stock from holdings and updates it.
  Helper methods to:
  getHoldingBySymbol: returns stock holding by symbol
  hasStock: checks if user already have that stock in the holdings list
  getOwnedQuantity: returns quantity of stock by stock symbol
   */

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

  // current total value of all holdings.
  double get totalHoldingsValue {
    return _holdings.fold( // fold() -> loop through holdings and sum values
      0,
      (sum, holding) => sum + holding.currentValue,
    );
  }

  // total balance = holdings value + cash balance
  double get totalBalance {
    return _cashBalance + totalHoldingsValue;
  }

  // total PnL of all holdings
  double get totalPnL{
    return _holdings.fold(
      0,
      (sum, holding) => sum + holding.profitLoss,
    );
  }

  // total PnL, profit or loss
  bool get isPositive{
    return totalPnL >= 0;
  }

  // total portfolio cost basis
  double get totalCostBasis{
    return _holdings.fold(
      0,
      (sum, holding) => sum + holding.totalCost,
    );
  }

  // total portfolio PnL percentage
  double get totalPnLPercentage{
    if (totalCostBasis == 0) {
      return 0;
    }
    return (totalPnL / totalCostBasis) * 100;
  }

}