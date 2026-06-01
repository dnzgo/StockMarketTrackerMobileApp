import 'package:flutter/material.dart';

class NewsExploreScreen extends StatefulWidget{
  const NewsExploreScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewsExploreState();
}
class _NewsExploreState extends State<NewsExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
    );
  }

}