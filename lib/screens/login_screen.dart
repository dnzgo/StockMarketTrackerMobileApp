import 'package:flutter/material.dart';
import '../utils/input_validation.dart';
import '../utils/app_theme.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../services/service_locator.dart';
import '../screens/main_navigation_screen.dart';
import '../screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authService = AuthService();
  final userService = UserService();

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  bool isLoading = false;

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    final email =
    emailController.text.trim();
    final password =
    passwordController.text.trim();

    // validation
    final emailError = InputValidation.validateEmail(email);
    if(emailError != null) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(emailError)),
      );
      return;
    }
    
    final passwordError = InputValidation.validatePassword(password);
    if(passwordError != null) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(passwordError)),
      );
      return;
    }

    try {
      await authService.signIn(
        email: email,
        password: password,
      );

      final user = authService.currentUser;

      if (user != null) {
        final data = await userService.getCurrentUserData(user.uid);

        portfolioService.setCashBalance(
          (data?["cashBalance"] ?? 0).toDouble(),
        );

        final holdings =
        await userService.getHoldings(uid: user.uid);

        portfolioService.setHoldings(holdings);
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
          const MainNavigationScreen(),
        ),
      );
    } catch (e) {
      String errorMessage =
          "Something went wrong";

      if (e.toString().contains(
          "invalid-credential")) {
        errorMessage =
        "Wrong email or password";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
    finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // destroy resources before widget dies
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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

                    const SizedBox(height: 20),

                    Image.asset(
                      "lib/assets/login_logo.png",
                      width: 300,
                    ),

                    const SizedBox(height: 60),

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

                    const SizedBox(height: 60),

                    InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: isLoading ? null : login,
                      child: Container(
                        width: 240,
                        height: 54,
                        decoration: AppColors.glassButtonDecoration,
                        child: Center(
                          child: isLoading
                              ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.textPrimaryColor,
                            ),
                          )
                              : const Text(
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
                    const SizedBox(height: 60),
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