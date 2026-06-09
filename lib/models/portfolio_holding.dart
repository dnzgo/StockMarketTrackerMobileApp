import '../models/stock.dart';

class PortfolioHolding {
  /*
  Portfolio holding is one holding in the portfolio,
  We save which stock, the quantity of the stock, average buy price of the stock,
  every buy needs to update quantity and average buy price,
  every sell needs to update quantity,
  and helper methods to get total cost, PnL, PnL percentage, PnL type (profit or loss)
   */
  final Stock stock;
  final double quantity;
  final double averageBuyPrice;

  const PortfolioHolding({
    required this.stock,
    required this.quantity,
    required this.averageBuyPrice,
  });

  // the current value of the stock (price * quantity)
  double get currentValue {
    return stock.price * quantity;
  }

  // total cost of stock (average buy price * quantity)
  double get totalCost {
    return averageBuyPrice * quantity;
  }

  // PnL calculation current - cost
  double get profitLoss {
    return currentValue - totalCost;
  }

  // PnLs percentage calculation
  double get profitLossPercentage {
    if (totalCost == 0) {
      return 0;
    }
    return (profitLoss / totalCost) * 100;
  }

  // return profit or loss
  bool get isPositive {
    return profitLoss >= 0;
  }

}