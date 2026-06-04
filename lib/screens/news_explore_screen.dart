import 'package:flutter/material.dart';
import '../widgets/news_card.dart';
import '../widgets/search_bar.dart';

class NewsExploreScreen extends StatefulWidget {
  const NewsExploreScreen({super.key});

  @override
  State<NewsExploreScreen> createState() => _NewsExploreState();
}

class _NewsExploreState extends State<NewsExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  child: Column(
                    children: [
                      Text("News"),
                      SizedBox(height: 4),
                      SearchBarWidget(hintText: "Search News...", onChanged: (text) {},),
                    ],
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          NewsCard(
                            title: "Apple unveils new AI-powered devices",
                            description:
                            "Apple introduced new AI features for its devices.",
                            imageUrl:
                            "https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=800",
                            time: "4h ago",
                          ),

                          NewsCard(
                            title: "Tesla stock jumps after strong earnings",
                            description:
                            "Tesla shares surged after earnings report.",
                            imageUrl:
                            "https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=800",
                            time: "2h ago",
                          ),

                          NewsCard(
                            title: "NVIDIA expands AI infrastructure",
                            description:
                            "NVIDIA announced new AI investments worldwide.",
                            imageUrl:
                            "https://images.unsplash.com/photo-1518770660439-4636190af475?w=800",
                            time: "1h ago",
                          ),

                          NewsCard(
                            title: "Microsoft launches new cloud services",
                            description:
                            "New Azure features were announced today.",
                            imageUrl:
                            "https://images.unsplash.com/photo-1633419461186-7d40a38105ec?w=800",
                            time: "5h ago",
                          ),

                          NewsCard(
                            title: "Amazon reports strong quarterly growth",
                            description:
                            "Amazon exceeded analyst expectations.",
                            imageUrl:
                            "https://images.unsplash.com/photo-1523474253046-8cd2748b5fd2?w=800",
                            time: "7h ago",
                          ),
                        ],
                      ),
                    )
                )
              ],
            )
        )
    );
  }
}