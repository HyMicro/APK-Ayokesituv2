import 'package:ayokesituv2/app/data/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart'; // Import for launching URLs

import '../controllers/location_controller.dart';

class Location extends GetView<LocationController> {
  const Location({super.key});

  @override
  Widget build(BuildContext context) {
    final tour = Get.arguments as Tour;

    // Function to launch URL
    void launchURL(String location) async {
      final coordinates = location.split(',');
      if (coordinates.length == 2) {
        final latitude = coordinates[0].trim();
        final longitude = coordinates[1].trim();
        final url = 'https://www.google.com/maps?q=$latitude,$longitude';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          Get.snackbar("Error", "Could not launch Google Maps");
        }
      } else {
        Get.snackbar("Error", "Invalid location data");
      }
    }

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.offAllNamed("/home"),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Placeholder for Google Map
          Positioned.fill(
            child: Container(
              color: Colors.grey[200],
              child: const Center(
                child: Text('Google Map Placeholder'),
              ),
            ),
          ),
          // Location Information Card
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Gambar dengan border melengkung di atas
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      tour.img,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Informasi lokasi
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tour.title ?? "Unknown Location",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              "4.9 (69 Reviews)", // Bisa diganti dengan data dinamis
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              tour.address ?? "Unknown Address",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: tour.location != null
                              ? () => launchURL(tour.location!)
                              : null, // Disable button if location is null
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text('Lihat di Google Maps'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
