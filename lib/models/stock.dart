class Stock {

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