import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/portfolio_service.dart';
import '../services/user_service.dart';
import '../services/service_locator.dart';
import '../models/stock.dart';
import '../models/transaction_record.dart';
import '../utils/app_theme.dart';
import '../utils/trade_validation.dart';
import '../widgets/stock_chart_card.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/trade_type_selection.dart';

class TradeScreen extends StatefulWidget {
  final String symbol;
  final String companyName;
  final double price;

  const TradeScreen({
    super.key,
    required this.symbol,
    required this.companyName,
    required this.price,
  });

  @override
  State<StatefulWidget> createState() => _TradeState();
}

class _TradeState extends State<TradeScreen> {

  final authService = AuthService();
  final userService = UserService();

  bool isBuySelected = true;
  double quantity = 1;

  bool canIncreaseQuantity() {
    final nextQuantity = quantity + 1;
    if(isBuySelected) {
      return TradeValidation.canBuy(
        cashBalance: portfolioService.cashBalance,
        quantity: nextQuantity,
        price: widget.price,
        feeRate: PortfolioService.tradingFeeRate,
      );
    }
    return TradeValidation.canSell(
      ownedQuantity: ownedQuantity,
      quantity: nextQuantity,
    );
  }

  bool canConfirmTrade() {
    if(isBuySelected) {
      return TradeValidation.canBuy(
        cashBalance: portfolioService.cashBalance,
        quantity: quantity,
        price: widget.price,
        feeRate: PortfolioService.tradingFeeRate,
      );
    }
    return TradeValidation.canSell(
      ownedQuantity: ownedQuantity,
      quantity: quantity,
    );
  }

  Future<void> executeTrade() async {
    final user = authService.currentUser;

    if(user == null) return;

    final stock = Stock(
      symbol: widget.symbol,
      companyName: widget.companyName,
      price: widget.price,
      changePercentage: 0,
    );

    final stockValue = quantity * stock.price;
    final fee = stockValue * PortfolioService.tradingFeeRate;

    final totalAmount = isBuySelected
        ? stockValue + fee
        : stockValue - fee;

    if (isBuySelected) {
      portfolioService.buyStock(stock: stock, quantity: quantity);
    } else {
      portfolioService.sellStock(stock: stock, quantity: quantity);
    }

    final holding = portfolioService.getHoldingBySymbol(widget.symbol);

    if(holding == null) {
      await userService.deleteHolding(
          uid: user.uid,
          symbol: widget.symbol,
      );
    } else {
      await userService.saveHolding(
          uid: user.uid,
          holding: holding,
      );
    }

    await userService.updateCashBalance(
        uid: user.uid,
        cashBalance: portfolioService.cashBalance
    );

    await userService.saveTransaction(
      uid: user.uid,
      transaction: TransactionRecord(
        type: isBuySelected ? "buy" : "sell",
        symbol: stock.symbol,
        companyName: stock.companyName,
        quantity: quantity,
        price: stock.price,
        fee: fee,
        totalAmount: totalAmount,
      ),
    );

    if(!mounted) return;

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${isBuySelected ? "Bought" : "Sold"} $quantity ${widget.symbol}",
        ),
      ),
    );
  }

  double get ownedQuantity =>
      portfolioService.getOwnedQuantity(widget.symbol);

  double get estimatedCost {
    final stockValue = quantity * widget.price;
    final fee = stockValue * PortfolioService.tradingFeeRate;
    return stockValue + fee;
  }

  @override
  void initState() {
    super.initState();

    print("TradeScreen cash: ${portfolioService.cashBalance}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppColors.appBackground(
        center: Alignment.bottomRight,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
             color: AppColors.textPrimaryColor
          ),
          title: Text(
            "Trade ${widget.symbol}",
            style: const TextStyle(
              color: AppColors.textPrimaryColor
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${isBuySelected ? "Buy" : "Sell"} ${widget.companyName}",
                style: const TextStyle(
                  color: AppColors.textPrimaryColor,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                widget.symbol,
                style: const TextStyle(
                  color: AppColors.textSecondaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 24),

              StockChartCard(
                symbol: widget.symbol,
              ),

              const SizedBox(height: 24),

              Container(
                decoration: AppColors.glassCardDecoration,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isBuySelected = true;
                            quantity = 1;
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: isBuySelected
                                ? AppColors.increasedValueColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: Text(
                              "Buy",
                              style: TextStyle(
                                color: AppColors.textPrimaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isBuySelected = false;
                            quantity = 1;
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: !isBuySelected
                                ? AppColors.decreasedValueColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: Text(
                              "Sell",
                              style: TextStyle(
                                color: AppColors.textPrimaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              TradeTypeSelection(),
              const SizedBox(height: 24),

              const Text(
                "Quantity",
                style: TextStyle(
                  color: AppColors.textPrimaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                height: 60,
                decoration: AppColors.glassCardDecoration,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: quantity > 1
                        ? () {
                        setState(() {
                          quantity--;
                        });
                      }
                      : null,
                      icon: const Icon(
                        Icons.remove,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          quantity.toString(),
                          style: const TextStyle(
                            color: AppColors.textPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: canIncreaseQuantity()
                        ? () {
                        setState(() {
                          quantity++;
                        });
                      }
                      : null,
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4,),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Available:",
                    style: TextStyle(
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  Text(
                    isBuySelected
                      ? "€${portfolioService.cashBalance.toStringAsFixed(2)}"
                      : ownedQuantity.toStringAsFixed(2) + " " + widget.symbol,
                    style: const TextStyle(
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              OrderSummaryCard(isBuySelected: isBuySelected, quantity: quantity, price: widget.price),

              InkWell(
                onTap: canConfirmTrade() ? executeTrade : null,

                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: canConfirmTrade() ? (isBuySelected
                        ? AppColors.increasedValueColor
                        : AppColors.decreasedValueColor)
                        : Colors.white12,
                  ),
                  child: Center(
                    child: Text(
                      "${isBuySelected ? "Buy" : "Sell"} ${widget.symbol}",
                      style: const TextStyle(
                        color: AppColors.textPrimaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}