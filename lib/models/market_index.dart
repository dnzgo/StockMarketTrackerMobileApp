class MarketIndex {
  final String name;
  final double value;
  final double changePercentage;

  const MarketIndex({
    required this.name,
    required this.value,
    required this.changePercentage,
  });

  bool get isPositive {
    return changePercentage >= 0;
  }
}