import 'package:flutter/material.dart';
import '../widgets/stock_card.dart';
import '../widgets/section_title.dart';
import '../widgets/quick_overview_card.dart';
import '../screens/stock_detail_screen.dart';
import '../screens/news_detail_screen.dart';

import '../widgets/news_card.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome back,"),
                      Text("Deniz Gözcü")
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person_outline),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 16),
              SectionTitle(title: "Market Overview"),
              SizedBox(height: 0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    QuickOverviewCard(marketName: "NASDAQ", marketValue: 2323.22, changePercentage: 2.50),
                    QuickOverviewCard(marketName: "NASDAQ", marketValue: 2323.22, changePercentage: 2.50),
                    QuickOverviewCard(marketName: "NASDAQ", marketValue: 2323.22, changePercentage: 2.50),
                    QuickOverviewCard(marketName: "NASDAQ", marketValue: 2323.22, changePercentage: 2.50),
                    QuickOverviewCard(marketName: "NASDAQ", marketValue: 2323.22, changePercentage: 2.50),
                    QuickOverviewCard(marketName: "NASDAQ", marketValue: 2323.22, changePercentage: 2.50),
                  ],
                ),
              ),
              SectionTitle(title: "Trending Stocks", actionText: "See all"),
              StockCard(
                symbol: "TSLA",
                companyName: "Tesla Inc.",
                price: 321.333,
                changePercentage: -1.2,
                isPositive: false,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StockDetailScreen(
                            symbol: "TSLA",
                            companyName: "Tesla Inc.",
                            price: 321.333,
                            changePercentage: -1.2,
                            isPositive: false,
                          )
                      )
                  );
                },
              ),
              StockCard(
                symbol: "TSLA",
                companyName: "Tesla Inc.",
                price: 321.333,
                changePercentage: -1.2,
                isPositive: false,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StockDetailScreen(
                            symbol: "TSLA",
                            companyName: "Tesla Inc.",
                            price: 321.333,
                            changePercentage: -1.2,
                            isPositive: false,
                          )
                      )
                  );
                },
              ),
              StockCard(
                symbol: "TSLA",
                companyName: "Tesla Inc.",
                price: 321.333,
                changePercentage: -1.2,
                isPositive: false,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StockDetailScreen(
                            symbol: "TSLA",
                            companyName: "Tesla Inc.",
                            price: 321.333,
                            changePercentage: -1.2,
                            isPositive: false,
                          )
                      )
                  );
                },
              ),
              SectionTitle(title: "Trending News", actionText: "See all"),
              NewsCard(
                title: "Apple unveils new AI-powered devices",
                description:
                "Apple introduced new AI features for its devices.",
                imageUrl:
                "https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=800",
                time: "4h ago",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(
                            title: "Apple launches new chip for apple AI",
                            articleText: "Veranstaltungen von Apple bieten sowie eine direktere Möglichkeit, sich über die neuesten Tools, Technologien und Ressourcen von Apple zu informieren. Die Räume befinden sich in Mitte, im Herzen von Berlins florierendem Business- und Startup-Ökosystem, und schließen an die Entwicklerzentren in Bengaluru, Cupertino, Shanghai und Singapur an.Europa ist die Heimat einer außergewöhnlichen Entwickler-Community, die Apps entwickelt und damit Verbindungen schafft, Kreativität fördert und Innovationen vorantreibt“, sagt Susan Prescott, Vice President of Worldwide Developer Relations bei Apple. „Wir waren schon immer davon überzeugt, dass Unglaubliches entsteht, wenn Entwickler:innen über die richtigen Tools und Ressourcen verfügen, um ihre beste Arbeit umzusetzen. Auf dieser Überzeugung basiert dieses Zentrum, und wir freuen uns darauf, zu sehen, was die Community in Zukunft entwickeln wird.“Das Apple Developer Center Berlin ist für Teams jeder Größe und in jeder Phase der App-Entwicklung konzipiert. Es wird als Basis für Präsenzveranstaltungen, Workshops und Einzeltermine dienen. Regelmäßige Veranstaltungen werden Entwickler:innen helfen, ihre Fähigkeiten zu verbessern und das Design, die Qualität und die Leistung ihrer Apps für iOS, iPadOS, macOS, tvOS, visionOS und watchOS zu optimieren. Die Veranstaltungen spiegeln die Vielfalt und Kreativität der europäischen Entwickler-Community wider. Darüber hinaus gibt es Bereiche für Diskussionen und spezielle Labore, in denen Entwickler:innen praktische Unterstützung durch Expert:innen von Apple in mehreren Sprachen erhalten können.",
                            source: "Reuters",
                            date: "June 6, 2026",
                            imageURL: "",
                          )
                      )
                  );
                },
              ),
              NewsCard(
                title: "Tesla stock jumps after strong earnings",
                description:
                "Tesla shares surged after earnings report.",
                imageUrl:
                "https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=800",
                time: "2h ago",
                onTap: () {},
              ),
            ],
          ),
        ),
      )
    );
  }

}