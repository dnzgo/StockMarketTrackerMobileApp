
class TransactionRecord {
  final String type;
  final String symbol;
  final String companyName;
  final double quantity;
  final double price;
  final double fee;
  final double totalAmount;

  const TransactionRecord({
    required this.type,
    required this.symbol,
    required this.companyName,
    required this.quantity,
    required this.price,
    required this.fee,
    required this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "symbol": symbol,
      "companyName": companyName,
      "quantity": quantity,
      "price": price,
      "fee": fee,
      "totalAmount": totalAmount,
    };
  }
}