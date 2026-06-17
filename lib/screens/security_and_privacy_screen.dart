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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: AppColors.glassCardDecoration,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Privacy Policy",
                  style: TextStyle(
                    color: AppColors.textPrimaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "Tradeon is committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how information is collected, used, and protected while using the application.",
                  style: TextStyle(
                    color: AppColors.textSecondaryColor,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),

                SizedBox(height: 24),

                Text(
                  "Data Collection",
                  style: TextStyle(
                    color: AppColors.textPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "Tradeon may collect account information, watchlist preferences, portfolio data, and application usage statistics to improve user experience and provide personalized financial insights.",
                  style: TextStyle(
                    color: AppColors.textSecondaryColor,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "Data Security",
                  style: TextStyle(
                    color: AppColors.textPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "All user information is handled using modern security practices. Authentication services, encrypted communication channels, and secure storage solutions are used to help protect sensitive information.",
                  style: TextStyle(
                    color: AppColors.textSecondaryColor,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "Third-Party Services",
                  style: TextStyle(
                    color: AppColors.textPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "Tradeon may integrate with trusted third-party services for market data, analytics, authentication, and infrastructure support. These services only receive the information necessary to perform their functions.",
                  style: TextStyle(
                    color: AppColors.textSecondaryColor,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "User Rights",
                  style: TextStyle(
                    color: AppColors.textPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "Users have the right to access, update, or request the removal of their personal information. Requests regarding privacy and data management can be submitted through official support channels.",
                  style: TextStyle(
                    color: AppColors.textSecondaryColor,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "Contact",
                  style: TextStyle(
                    color: AppColors.textPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "If you have questions regarding privacy, security, or data handling practices, please contact the Tradeon support team for further assistance.",
                  style: TextStyle(
                    color: AppColors.textSecondaryColor,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}