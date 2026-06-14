import 'package:flutter/material.dart';
import '../utils/input_validation.dart';
import '../utils/app_theme.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../screens/main_navigation_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final authService = AuthService();
  final userService = UserService();

  bool isLoading = false;

  final nameController =
  TextEditingController();

  final surnameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  Future<void> signUp() async {

    setState(() {
      isLoading = true;
    });

    final email =
        emailController.text.trim();
    final name =
        nameController.text.trim();
    final surname =
        surnameController.text.trim();
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

    final nameError = InputValidation.validateName(name);
    if(nameError != null) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(nameError)),
      );
      return;
    }

    final surnameError = InputValidation.validateName(surname);
    if(surnameError != null) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(surnameError)),
      );
      return;
    }

    try {
      final credential = await authService.signUp(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;

      await userService.createUser(
        uid: uid,
        firstName: name,
        surname: surname,
        email: email,
      );

      // if screen removed stop
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
          const MainNavigationScreen(),
        ),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      String errorMessage =
          "Something went wrong";

      if (e.toString().contains("email-already-in-use")) {
        errorMessage = "This email is already registered";
      } else if (e.toString().contains("weak-password")) {
        errorMessage = "Password is too weak";
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }

  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
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
                            controller: nameController,
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
                        ),
                       ),
                      ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Container(
                            decoration: AppColors.glassCardDecoration,
                        child: TextField(
                          controller: surnameController,
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
                        ),
                       ),
                     ),
                    ],
                   ),

                    const SizedBox(height: 24),

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
                      onTap: signUp,
                      child: Container(
                        width: 240,
                        height: 54,
                        decoration: AppColors.glassButtonDecoration,
                        child: Center(
                          child: isLoading
                              ? const SizedBox(
                            width: 24,
                            height: 24,
                            child:
                            CircularProgressIndicator(
                              strokeWidth: 3,
                              color:
                              AppColors.textPrimaryColor,
                            ),
                          )
                              : const Text(
                            "Create Account",
                            style: TextStyle(
                              color:
                              AppColors.textPrimaryColor,
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