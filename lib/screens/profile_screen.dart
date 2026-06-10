import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/screens/premium_screen.dart';
import '../utils/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: AppColors.textPrimaryColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),

          const Center(
            child: CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person_outline,
                size: 45,
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Emir Yalçınkaya",
            style: TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "emir@gmail.com",
            style: TextStyle(
              color: AppColors.textSecondaryColor,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 70),

          _buildProfileButton(
            icon: Icons.diamond_outlined,
            title: "Upgrade Premium",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PremiumScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          _buildProfileButton(
            icon: Icons.settings,
            title: "Account Settings",
            onTap: () {},
          ),

          const SizedBox(height: 16),

          _buildProfileButton(
            icon: Icons.security,
            title: "Security & Privacy",
            onTap: () {},
          ),

          const SizedBox(height: 16),

          _buildProfileButton(
            icon: Icons.help_outline,
            title: "Help & Support",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProfileButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          height: 60,
          decoration: AppColors.glassButtonDecoration,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppColors.textPrimaryColor,
                size: 24,
              ),

              const SizedBox(width: 20),

              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}