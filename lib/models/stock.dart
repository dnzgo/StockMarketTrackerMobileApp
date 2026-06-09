class Stock {
  /*
  stock model for data:
  symbol of the stock,
  company name of the stock,
  price of the stock,
  change percentage of the stock,
  helper method to get PnL type(profit or loss)
   */

  final String symbol;
  final String companyName;
  final double price;
  final double changePercentage;

  const Stock({
    required this.symbol,
    required this.companyName,
    required this.price,
    required this.changePercentage,
  });

  // to get stock isPositive or not check changePercentage
  bool get isPositive {
    return changePercentage >= 0;
  }

}