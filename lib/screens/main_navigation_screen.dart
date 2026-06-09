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
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(
        onSeeAllTrendingStocks: () {
          setState(() {
            selectedIndex = 2;
            selectedCategory = "Trends";
          });
        },
        onSeeAllTrendingNews: () {
          setState(() {
            selectedIndex = 1;
            selectedCategory = "Trends";
          });
        },
      ),
      NewsExploreScreen(
        initialCategory: selectedCategory,
      ),
      StockExploreScreen(
        initialCategory: selectedCategory,
      ),
      const PortfolioScreen(),
      const ProfileScreen(),
    ];

    return Container(
      decoration: AppColors.appBackground(
        center: Alignment.bottomRight,
      ),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            screens[selectedIndex],
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.backgroundColor,
                      AppColors.backgroundLightingColor,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(Icons.home_rounded, 0),
                    _buildNavItem(Icons.newspaper_rounded, 1),
                    _buildNavItem(Icons.bar_chart_rounded, 2),
                    _buildNavItem(Icons.pie_chart_rounded, 3),
                    _buildNavItem(Icons.person_rounded, 4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          size: 34,
          color: isSelected
              ? Colors.white
              : Colors.white.withOpacity(0.4),
        ),
      ),
    );
  }
}