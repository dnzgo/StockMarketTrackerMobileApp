import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/widgets/trade_type_selection.dart';
import '../services/service_locator.dart';
import '../models/stock.dart';
import '../utils/app_theme.dart';
import '../widgets/stock_chart_card.dart';
import '../widgets/order_summary_card.dart';

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
  bool isBuySelected = true;
  double quantity = 1;

  bool canIncreaseQuantity() {
    final nextQuantity = quantity + 1;
    if(isBuySelected) {
      final nextCost = nextQuantity * widget.price;
      return nextCost <= portfolioService.cashBalance;
    } else {
      final ownedQuantity = portfolioService.getOwnedQuantity(widget.symbol);
      return nextQuantity <= ownedQuantity;
    }
  }

  bool canConfirmTrade() {
    if(isBuySelected) {
      return quantity * widget.price <= portfolioService.cashBalance;
    }
    return portfolioService.getOwnedQuantity(widget.symbol) >= quantity;
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

              const StockChartCard(),

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
                      : portfolioService.getOwnedQuantity(widget.symbol).toStringAsFixed(2) + " " + widget.symbol,
                    style: const TextStyle(
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              OrderSummaryCard(isBuySelected: isBuySelected, quantity: quantity, price: widget.price),

              InkWell(
                onTap: canConfirmTrade() ? () {
                  final stock = Stock(
                    symbol: widget.symbol,
                    companyName: widget.companyName,
                    price: widget.price,
                    changePercentage: 0,
                  );
                  if (isBuySelected) {
                    portfolioService.buyStock(
                      stock: stock,
                      quantity: quantity.toDouble(),
                    );
                  } else {
                    portfolioService.sellStock(
                      stock: stock,
                      quantity: quantity.toDouble(),
                    );
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${isBuySelected ? "Bought" : "Sold"} $quantity ${widget.symbol}",
                      ),
                    ),
                  );
                } : null,
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