import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class SecurityAndPrivacyScreen extends StatefulWidget {
  const SecurityAndPrivacyScreen({super.key});

  @override
  State<SecurityAndPrivacyScreen> createState() =>
      _SecurityAndPrivacyScreenState();
}

class _SecurityAndPrivacyScreenState
    extends State<SecurityAndPrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppColors.appBackground(
        center: Alignment.bottomRight,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: AppColors.textPrimaryColor,
          ),
          title: const Text(
            "Security & Privacy",
            style: TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: const Center(
          child: Text(
            "Security & Privacy Screen",
            style: TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}