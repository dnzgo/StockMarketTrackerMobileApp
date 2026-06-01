import 'package:flutter/material.dart';

class StockExploreScreen extends StatefulWidget{
  const StockExploreScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StockExploreState();
}
class _StockExploreState extends State<StockExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Explore"),
      ),
    );
  }

}