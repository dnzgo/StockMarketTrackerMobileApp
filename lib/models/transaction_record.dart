import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionRecord {
  final String type;
  final String symbol;
  final String companyName;
  final double quantity;
  final double price;
  final double fee;
  final double totalAmount;
  final DateTime? createdAt;

  const TransactionRecord({
    required this.type,
    required this.symbol,
    required this.companyName,
    required this.quantity,
    required this.price,
    required this.fee,
    required this.totalAmount,
    this.createdAt,
  });

  factory TransactionRecord.fromMap(Map<String, dynamic> data) {
    return TransactionRecord(
      type: data["type"] ?? "",
      symbol: data["symbol"] ?? "",
      companyName: data["companyName"] ?? "",
      quantity: (data["quantity"] ?? 0).toDouble(),
      price: (data["price"] ?? 0).toDouble(),
      fee: (data["fee"] ?? 0).toDouble(),
      totalAmount: (data["totalAmount"] ?? 0).toDouble(),
      createdAt: data["createdAt"] == null
          ? null
          : (data["createdAt"] as Timestamp).toDate(),
    );
  }

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