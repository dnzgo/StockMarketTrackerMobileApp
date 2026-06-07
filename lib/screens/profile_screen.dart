import 'package:flutter/material.dart';
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

          Center(
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
        ],
      ),
    );
  }
}