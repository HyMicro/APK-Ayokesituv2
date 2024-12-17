import 'package:flutter/material.dart';

import '../controllers/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController controller = SignUpController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Sign up now"),
            TextField(decoration: InputDecoration(hintText: "Name")),
            TextField(decoration: InputDecoration(hintText: "Email")),
            TextField(decoration: InputDecoration(hintText: "Password"), obscureText: true),
            ElevatedButton(onPressed: () => controller.createAccount(context), child: Text("Create Account")),
            ElevatedButton(onPressed: () => controller.signInWithGoogle(context), child: Text("Sign in with Google")),
            TextButton(onPressed: () => controller.navigateToSignIn(context), child: Text("Already have an account? Sign In")),
          ],
        ),
      ),
    );
  }
}
