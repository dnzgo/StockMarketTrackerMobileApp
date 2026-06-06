import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Trade " + widget.symbol),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.companyName),
            SizedBox(height: 8,),
            Text(widget.price.toStringAsFixed(2)),

            SizedBox(height: 24,),
            Text("Trade Type"),
            SizedBox(height: 24,),
            Text("Quantity"),
            SizedBox(height: 24,),
            Text("Estimated Total"),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: (){},
              child: Text("Confirm Trade"),
            )
          ],
        ),
      ),
    );
  }

}