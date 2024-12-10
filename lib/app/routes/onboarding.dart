import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/pages/login/login_page.dart';

class AyoKesitu extends StatelessWidget {
  const AyoKesitu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: onboardings(),
    );
  }
}

class onboardings extends StatelessWidget {
  const onboardings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/img/png/onboarding.png', // Add your image in the assets folder
              fit: BoxFit.cover,
            ),
          ),
          // Semi-transparent overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title Text
                const Text(
                  'BROMO',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                // Description Text
                const Text(
                  'The procurement of Jeeps for the purpose of crossing Mount Bromo is very important, '
                  'because the rugged landscape requires durable vehicles and skilled operators. Furthermore, regulations set by the Bromo Tengger Semeru National Park further support the use of jeeps to facilitate safer and more effective exploration.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                // Continue Button
                ElevatedButton(
                  onPressed: () {
                    Get.to(LoginPage());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}