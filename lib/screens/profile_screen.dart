import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../utils/app_theme.dart';
import '../utils/string_formatter.dart';
import '../screens/premium_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/security_and_privacy_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  final authService = AuthService();
  final userService = UserService();

  String firstName = "";
  String surname = "";
  String email = "";
  double cashBalance = 0;

  Future<void> loadUserData() async {
    final user = authService.currentUser;

    if(user == null) return;

    final data = await userService.getCurrentUserData(user.uid);

    if(data == null) return;
    if(!mounted) return;

    setState(() {
      firstName = data["firstName"] ?? "";
      surname = data["surname"] ?? "";
      email = data["email"] ?? "";
      cashBalance = data["cashBalance"] ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

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

          Text(
            "${StringFormatter.toTitleCase(firstName)} ${StringFormatter.toTitleCase(surname)}",
            style: TextStyle(
              color: AppColors.textPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            email,
            style: TextStyle(
              color: AppColors.textSecondaryColor,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Container(
              height: 90,
              decoration: AppColors.glassCardDecoration,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Balance",
                          style: TextStyle(
                            color: AppColors.textSecondaryColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "€${cashBalance.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: AppColors.textPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: AppColors.glassButtonDecoration,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            size: 18,
                            color: AppColors.textPrimaryColor,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Add",
                            style: TextStyle(
                              color: AppColors.textPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

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
            isCentered: true,
          ),

          const SizedBox(height: 16),

          _buildProfileButton(
            icon: Icons.settings,
            title: "Account Settings",
            isCentered: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          _buildProfileButton(
            icon: Icons.security,
            title: "Security & Privacy",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SecurityAndPrivacyScreen(),
                ),
              );
            },
            isCentered: true,
          ),

          const SizedBox(height: 16),

          _buildProfileButton(
            icon: Icons.logout_rounded,
            title: "Log Out",
            onTap: () {},
            isCentered: true,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isCentered = false,
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
            mainAxisAlignment:
            isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: AppColors.textPrimaryColor,
                size: 24,
              ),

              const SizedBox(width: 12),

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