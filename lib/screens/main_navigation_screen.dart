import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/screens/home_screen.dart';
import 'package:stock_market_tracker_mobile_app/screens/news_explore_screen.dart';
import 'package:stock_market_tracker_mobile_app/screens/stock_explore_screen.dart';
import 'package:stock_market_tracker_mobile_app/screens/portfolio_screen.dart';
import 'package:stock_market_tracker_mobile_app/screens/profile_screen.dart';
import 'package:stock_market_tracker_mobile_app/utils/app_theme.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigationScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    NewsExploreScreen(),
    StockExploreScreen(),
    PortfolioScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppColors.appBackground(
        center: Alignment.bottomRight,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: screens[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          backgroundColor: Colors.black.withOpacity(0),
          elevation: 0,
          selectedItemColor: AppColors.selectedItemColor,
          unselectedItemColor: AppColors.unselectedItemColor,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: "News",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: "Stocks",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: "Portfolio",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}