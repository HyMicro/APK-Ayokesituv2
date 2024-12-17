import 'package:flutter/material.dart';

import '../controllers/signin_controller.dart';

class SignInScreen extends StatelessWidget {
  final SignInController controller = SignInController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Sign in now"),
            TextField(decoration: InputDecoration(hintText: "Email")),
            TextField(decoration: InputDecoration(hintText: "Password"), obscureText: true),
            TextButton(onPressed: () => controller.navigateToForgotPassword(context), child: Text("Forgot password?")),
            ElevatedButton(onPressed: () => controller.signIn(context), child: Text("Sign In")),
            ElevatedButton(onPressed: () => controller.signInWithGoogle(context), child: Text("Sign in with Google")),
            TextButton(onPressed: () => controller.navigateToSignUp(context), child: Text("Don't have an account? Sign Up")),
          ],
        ),
      ),
    );
  }
}
