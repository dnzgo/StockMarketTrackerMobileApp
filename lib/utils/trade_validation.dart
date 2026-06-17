class TradeValidation {
  static bool canBuy({
    required double cashBalance,
    required double quantity,
    required double price,
    required double feeRate,
  }) {
    final stockValue = quantity * price;
    final fee = stockValue * feeRate;
    final totalCost = stockValue + fee;

    return totalCost <= cashBalance;
  }

  static bool canSell({
    required double ownedQuantity,
    required double quantity,
  }) {
    return ownedQuantity >= quantity;
  }
}