import 'package:flutter/material.dart';

import '../controllers/otp_controller.dart';

class OTPVerificationScreen extends StatelessWidget {
  final OTPVerificationController controller = OTPVerificationController();

  OTPVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("OTP Verification"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var i = 0; i < 6; i++) Expanded(child: TextField(textAlign: TextAlign.center)),
              ],
            ),
            ElevatedButton(onPressed: () => controller.verifyOTP(context), child: Text("Verify")),
            Text("Resend code in 01:26"),
          ],
        ),
      ),
    );
  }
}
