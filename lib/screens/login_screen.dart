import 'package:flutter/material.dart';
import 'package:stock_market_tracker_mobile_app/screens/main_navigation_screen.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  String username = "";
  String emailAddress = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("StockMarket"),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // login widgets
              Text("Welcome to Stock Market"),
              SizedBox(height: 32),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Email"),
                      onChanged: (text) {
                        emailAddress = text;
                      },
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Password"),
                      onChanged: (text) {
                        password = text;
                      },
                      obscureText: true, // hide the password text
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(onPressed: () {
                      // login logic
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => MainNavigationScreen()
                        )
                      );
                    },
                      child: Text("Login"),
                    )
                  ],
                ),
              )

            ],
          ),
        ),
      )
    );
  }

}