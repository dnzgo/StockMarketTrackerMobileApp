import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool priceAlertsEnabled = true;
  bool newsNotificationsEnabled = false;
  bool biometricLoginEnabled = true;
  bool darkModeEnabled = true;

  Widget buildGlassToggle({
    required String title,
    required String subtitle,
    required bool value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        decoration: AppColors.glassCardDecoration,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondaryColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            AnimatedContainer(
              duration: const Duration(
                milliseconds: 250,
              ),
              width: 52,
              height: 28,
              decoration: value
                  ? AppColors
                  .selectedGlassToggleDecoration
                  : AppColors.glassToggleDecoration,
              child: AnimatedAlign(
                duration: const Duration(
                  milliseconds: 250,
                ),
                alignment: value
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: 18,
                  height: 18,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            "Account Settings",
            style: TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            buildGlassToggle(
              title: "Notifications",
              subtitle: "Receive app notifications",
              value: notificationsEnabled,
              onTap: () {
                setState(() {
                  notificationsEnabled =
                  !notificationsEnabled;
                });
              },
            ),

            buildGlassToggle(
              title: "Price Alerts",
              subtitle:
              "Get notified about price changes",
              value: priceAlertsEnabled,
              onTap: () {
                setState(() {
                  priceAlertsEnabled =
                  !priceAlertsEnabled;
                });
              },
            ),

            buildGlassToggle(
              title: "News Notifications",
              subtitle:
              "Receive market news updates",
              value: newsNotificationsEnabled,
              onTap: () {
                setState(() {
                  newsNotificationsEnabled =
                  !newsNotificationsEnabled;
                });
              },
            ),

            buildGlassToggle(
              title: "Biometric Login",
              subtitle:
              "Use Face ID or Touch ID",
              value: biometricLoginEnabled,
              onTap: () {
                setState(() {
                  biometricLoginEnabled =
                  !biometricLoginEnabled;
                });
              },
            ),

            buildGlassToggle(
              title: "Dark Mode",
              subtitle:
              "Use dark appearance",
              value: darkModeEnabled,
              onTap: () {
                setState(() {
                  darkModeEnabled =
                  !darkModeEnabled;
                });
              },
            ),
            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: AppColors.glassCardDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "About Tradeon",
                    style: TextStyle(
                      color: AppColors.textPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    "Tradeon is a modern stock market tracking application designed to provide market insights, financial news, and portfolio monitoring tools in a simple and intuitive experience.",
                    style: TextStyle(
                      color: AppColors.textSecondaryColor,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    "Development Team",
                    style: TextStyle(
                      color: AppColors.textPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "• Emir Yalçınkaya\n"
                        "• Deniz Gözcü\n"
                        "• Batu Kerem Yıldırım\n"
                        "• Ada Uğur Abur",
                    style: TextStyle(
                      color: AppColors.textSecondaryColor,
                      fontSize: 14,
                      height: 1.8,
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    "Version 1.0.0",
                    style: TextStyle(
                      color: AppColors.textSecondaryColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}