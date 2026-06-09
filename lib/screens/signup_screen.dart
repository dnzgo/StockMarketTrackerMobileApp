import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/screens/main_navigation_screen.dart';
import 'package:stock_market_tracker_mobile_app/utils/app_theme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String name = "";
  String surname = "";
  String emailAddress = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppColors.appBackground(
        center: Alignment.center,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: AppColors.textPrimaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Create an Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w200,
                      ),
                    ),

                    const Text(
                      "Tradeon",
                      style: TextStyle(
                        color: AppColors.textSecondaryColor,
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 50),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: AppColors.glassCardDecoration,
                          child: TextField(
                          style: const TextStyle(
                            color: AppColors.textPrimaryColor,
                          ),
                          decoration: const InputDecoration(
                            hintText: "Name*",
                            hintStyle: TextStyle(
                              color: AppColors.textSecondaryColor,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          onChanged: (text) {
                            name = text;
                          },
                        ),
                       ),
                      ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Container(
                            decoration: AppColors.glassCardDecoration,
                        child: TextField(
                          style: const TextStyle(
                            color: AppColors.textPrimaryColor,
                          ),
                          decoration: const InputDecoration(
                            hintText: "Surname*",
                            hintStyle: TextStyle(
                              color: AppColors.textSecondaryColor,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          onChanged: (text) {
                            surname = text;
                          },
                        ),
                       ),
                     ),
                    ],
                   ),

                    const SizedBox(height: 24),

                    Container(
                      decoration: AppColors.glassCardDecoration,
                      child: TextField(
                        style: const TextStyle(
                          color: AppColors.textPrimaryColor,
                        ),
                        decoration: const InputDecoration(
                          hintText: "Email*",
                          hintStyle: TextStyle(
                            color: AppColors.textSecondaryColor,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        onChanged: (text) {
                          emailAddress = text;
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    Container(
                      decoration: AppColors.glassCardDecoration,
                      child: TextField(
                        style: const TextStyle(
                          color: AppColors.textPrimaryColor,
                        ),
                        decoration: const InputDecoration(
                          hintText: "Password*",
                          hintStyle: TextStyle(
                            color: AppColors.textSecondaryColor,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        obscureText: true,
                        onChanged: (text) {
                          password = text;
                        },
                      ),
                    ),

                    const SizedBox(height: 70),

                    InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const MainNavigationScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 240,
                        height: 54,
                        decoration: AppColors.glassButtonDecoration,
                        child: const Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              color: AppColors.textPrimaryColor,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}