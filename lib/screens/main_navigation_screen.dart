import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/screens/home_screen.dart';
import 'package:stock_market_tracker_mobile_app/screens/news_explore_screen.dart';
import 'package:stock_market_tracker_mobile_app/screens/stock_explore_screen.dart';
import 'package:stock_market_tracker_mobile_app/screens/portfolio_screen.dart';
import 'package:stock_market_tracker_mobile_app/screens/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainNavigationState();

}
class _MainNavigationState extends State<MainNavigationScreen> {
  int selectedIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    NewsExploreScreen(),
    StockExploreScreen(),
    PortfolioScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.deepPurple,
          backgroundColor: Colors.purple,
          unselectedItemColor: Colors.white,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "news"),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "stocks"),
            BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: "portfolio"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
          ]
      ),
    );
  }

}