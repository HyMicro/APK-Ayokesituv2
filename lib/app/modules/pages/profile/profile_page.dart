import 'package:ayokesituv2/app/modules/pages/maps/controllers/location_controller.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends GetView {
  ProfilePage({super.key}); // Variabel untuk menyimpan gambar profil

  String name = "Ali Sofyan";
  String email = " AliSofyan@gmail.com";
  String firstName = "Ali";
  String lastName = "Sofyan";
  String location = "Indonesia";
  File? _image;

  final locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String? imagePath = box.read('profileImage');
    if (imagePath != null) {
      _image = File(imagePath); // Load the image from the path
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                "Your Profile",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'WorkSans',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ClipOval(
                child: _image != null
                    ? Image.file(
                        _image!,
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      )
                    : SvgPicture.asset(
                        'assets/img/svg/profile.svg',
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
              ),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'WorkSans',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.offAllNamed("/profile_edit");
                },
                child: Container(
                    width: 295,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/img/png/profile.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'Profile',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'WorkSans',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 95,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/img/svg/Chevron right.svg',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ])),
              ),
              const SizedBox(height: 20),
              Container(
                width: 295,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/img/svg/Credit card.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'WorkSans',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/img/svg/Chevron right.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  await locationController.getCurrentLocation();

                  if (locationController.currentPosition != null) {
                    locationController.openGoogleMaps();
                  } else {
                    Get.snackbar("Error", "Unable to fetch current location");
                  }
                },
                child: Container(
                  width: 295,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/img/png/Location.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'My Location',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'WorkSans',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/img/svg/Chevron right.svg',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 295,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.offNamed("/order");
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/img/svg/Check circle.svg',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'Your Order',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'WorkSans',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 65,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/img/svg/Chevron right.svg',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: 295,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/img/png/Settings.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Setting',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'WorkSans',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 95,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/img/svg/Chevron right.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ])),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: 295,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/img/png/Logout.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'WorkSans',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 95,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/img/svg/Chevron right.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ])) // Lainnya tetap sama
            ],
          ),
        ),
      ),
    );
  }
}
