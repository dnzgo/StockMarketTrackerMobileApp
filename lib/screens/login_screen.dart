import 'package:flutter/material.dart';
import '../screens/main_navigation_screen.dart';
import '../utils/app_theme.dart';
import '../screens/signup_screen.dart';
import '../services/auth_sevice.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authService = AuthService();

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  Future<void> login() async {
    final email =
    emailController.text.trim();
    final password =
    passwordController.text.trim();
    // validation
    if (email.isEmpty ||
        password.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
          Text("Please fill all fields"),
        ),
      );
      return;
    }

    if (!email.contains("@")) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
          Text("Invalid email"),
        ),
      );
      return;
    }

    try {
      // Firebase login later
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
          const MainNavigationScreen(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content:
          Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppColors.appBackground(
        center: Alignment.center,
      ),
      child: Scaffold(
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
                      "Welcome to",
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

                    Container(
                      decoration: AppColors.glassCardDecoration,
                      child: TextField(
                        controller: emailController,
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
                      ),
                    ),

                    const SizedBox(height: 24),

                    Container(
                      decoration: AppColors.glassCardDecoration,
                      child: TextField(
                        controller: passwordController,
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
                      ),
                    ),

                    const SizedBox(height: 70),

                    InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: login,
                      child: Container(
                        width: 240,
                        height: 54,
                        decoration: AppColors.glassButtonDecoration,
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: AppColors.textPrimaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Don't have an account? Create Account",
                        style: TextStyle(
                          color: AppColors.textSecondaryColor,
                          fontSize: 14,
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