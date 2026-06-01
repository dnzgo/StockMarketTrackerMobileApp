import 'package:flutter/material.dart';

class PortfolioScreen extends StatefulWidget{
  const PortfolioScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PortfolioState();
}
class _PortfolioState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Portfolio"),
      ),
    );
  }

}