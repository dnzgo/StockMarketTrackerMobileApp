import 'package:flutter/material.dart';
import '../widgets/news_card.dart';

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
        title: const Text("News"),
      ),
      body: const NewsCard(
        title: "Apple unveils new AI-powered devices",
        description: "Apple introduced new AI features for its devices.",
        imageUrl: "https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=800",
        time: "4h ago",
      ),
    );
  }

}