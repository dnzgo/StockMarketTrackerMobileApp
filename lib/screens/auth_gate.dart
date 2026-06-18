import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../services/service_locator.dart';
import '../screens/login_screen.dart';
import '../screens/main_navigation_screen.dart';
import '../utils/app_theme.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final authService = AuthService();
  final userService = UserService();

  bool isLoading = true;
  bool isLoggedIn = false;

  Future<void> checkAuthState() async {
    final startTime = DateTime.now();

    final user = authService.currentUser;

    if (user != null) {
      final data = await userService.getCurrentUserData(user.uid);

      portfolioService.setCashBalance(
        (data?["cashBalance"] ?? 0).toDouble(),
      );

      final holdings = await userService.getHoldings(uid: user.uid);
      portfolioService.setHoldings(holdings);

      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }

    final elapsedTime = DateTime.now().difference(startTime);
    const minimumSplashDuration = Duration(seconds: 2);

    if (elapsedTime < minimumSplashDuration) {
      await Future.delayed(minimumSplashDuration - elapsedTime);
    }

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    checkAuthState();
  }

  @override
  Widget build(BuildContext context) {
    print("AuthGate build isLoading: $isLoading");
    if (isLoading) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "lib/assets/app_logo.png",
                width: 300,
              ),

              const SizedBox(height: 32),

              const CircularProgressIndicator(
                color: AppColors.textPrimaryColor,
                strokeWidth: 2,
              ),
            ],
          ),
        ),
      );
    }

    return isLoggedIn
        ? const MainNavigationScreen()
        : const LoginScreen();
  }
}