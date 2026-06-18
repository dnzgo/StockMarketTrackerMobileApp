class StockStatistic {
  /*
  stock statistics model:
  open price,
  high price,
  low price,
  trading volume,

  used in stock detail screen
  to display daily market statistics
*/

  final double open;
  final double high;
  final double low;
  final double volume;

  const StockStatistic({
    required this.open,
    required this.high,
    required this.low,
    required this.volume,
  });
}