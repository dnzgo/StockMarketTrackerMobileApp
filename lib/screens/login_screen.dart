import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key, required this.title});
  final String title;
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
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // login widgets
            Text("Welcome to Stock Market"),
            SizedBox(height: 16),
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
              obscureText: true, // hide the text
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: () {
              // login logic
            },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }

}