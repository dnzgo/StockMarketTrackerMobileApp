import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/utils/app_theme.dart';

class TradeScreen extends StatefulWidget{
  final String symbol;
  final String companyName;
  final double price;

  const TradeScreen({super.key,
    required this.symbol,
    required this.companyName,
    required this.price
  });

  @override
  State<StatefulWidget> createState() => _TradeState();

}

class _TradeState extends State<TradeScreen> {
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
            color: Colors.white,
          ),
          title: Text(
            "Trade ${widget.symbol}",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.companyName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "\$${widget.price.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                "Trade Type",
                style: TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 24),

              const Text(
                "Quantity",
                style: TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 24),

              const Text(
                "Estimated Total",
                style: TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                child: const Text("Confirm Trade"),
              ),
            ],
          ),
        ),
      ),
    );
  }

}