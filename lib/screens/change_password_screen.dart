import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/app_theme.dart';
import '../utils/input_validation.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState
    extends State<ChangePasswordScreen> {

  final authService = AuthService();

  final currentPasswordController =
  TextEditingController();

  final newPasswordController =
  TextEditingController();

  final confirmPasswordController =
  TextEditingController();

  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  bool isLoading = false;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> changePassword() async {

    final currentPassword =
    currentPasswordController.text.trim();

    final newPassword =
    newPasswordController.text.trim();

    final confirmPassword =
    confirmPasswordController.text.trim();

    if (currentPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Current password is required",
          ),
        ),
      );
      return;
    }

    final passwordError =
    InputValidation.validatePassword(
      newPassword,
    );

    if (passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(passwordError),
        ),
      );
      return;
    }

    if (currentPassword == newPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "New password must be different",
          ),
        ),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Passwords do not match",
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      await authService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Password updated successfully",
          ),
        ),
      );

      Navigator.pop(context);

    } catch (e) {

      String errorMessage =
          "Failed to update password";

      if (e.toString().contains(
          "invalid-credential")) {
        errorMessage =
        "Current password is incorrect";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );

    } finally {

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return Container(
      decoration: AppColors.glassCardDecoration,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          color: AppColors.textPrimaryColor,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.textSecondaryColor,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          suffixIcon: IconButton(
            onPressed: onToggle,
            icon: Icon(
              obscureText
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
              color: AppColors.textSecondaryColor,
            ),
          ),
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
            "Change Password",
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
            const SizedBox(height: 50),

            buildPasswordField(
              controller:
              currentPasswordController,
              hintText: "Current Password",
              obscureText:
              obscureCurrentPassword,
              onToggle: () {
                setState(() {
                  obscureCurrentPassword =
                  !obscureCurrentPassword;
                });
              },
            ),

            const SizedBox(height: 24),

            buildPasswordField(
              controller:
              newPasswordController,
              hintText: "New Password",
              obscureText:
              obscureNewPassword,
              onToggle: () {
                setState(() {
                  obscureNewPassword =
                  !obscureNewPassword;
                });
              },
            ),

            const SizedBox(height: 24),

            buildPasswordField(
              controller:
              confirmPasswordController,
              hintText: "Confirm Password",
              obscureText:
              obscureConfirmPassword,
              onToggle: () {
                setState(() {
                  obscureConfirmPassword =
                  !obscureConfirmPassword;
                });
              },
            ),

            const SizedBox(height: 60),

            InkWell(
              borderRadius:
              BorderRadius.circular(32),
              onTap: isLoading
                  ? null
                  : changePassword,
              child: Container(
                height: 56,
                decoration:
                AppColors.glassButtonDecoration,
                child: Center(
                  child: isLoading
                      ? const SizedBox(
                    width: 22,
                    height: 22,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors
                          .textPrimaryColor,
                    ),
                  )
                      : const Text(
                    "Update Password",
                    style: TextStyle(
                      color: AppColors
                          .textPrimaryColor,
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}