import 'package:flutter/material.dart';

import '../../login_forgot/views/forgot_password.dart';
import '../../signup/views/signup_view.dart';


class SignInController {
  void signIn(BuildContext context) {
    // Logic for signing in
  }

  void signInWithGoogle(BuildContext context) {
    // Logic for signing in with Google
  }

  void navigateToSignUp(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  void navigateToForgotPassword(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
  }
}
