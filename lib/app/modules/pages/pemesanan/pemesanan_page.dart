import 'package:ayokesituv2/app/data/models/article_model.dart';
import 'package:ayokesituv2/app/modules/pages/pemesanan/controller/pemesanan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PemesananPage extends StatelessWidget {
  const PemesananPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PemesananController());
    final tour = Get.arguments as Tour;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image and overlay
            Stack(
              children: [
                Obx(() {
                  if (controller.isInitialized.value) {
                    final aspectRatio =
                        controller.videoPlayerController.value.aspectRatio;
                    return AspectRatio(
                      aspectRatio: aspectRatio > 0 ? aspectRatio : 16 / 9,
                      child: VideoPlayer(controller.videoPlayerController),
                    );
                  } else {
                    return Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.black,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
                Positioned(
                  top: 40,
                  left: 20,
                  child: GestureDetector(
                      onTap: () {
                        Get.offAllNamed("/home");
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white)),
                ),
                const Positioned(
                  top: 40,
                  right: 20,
                  child: Icon(Icons.favorite_border, color: Colors.white),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and location
                  Text(
                    tour.title, // Use tour title from arguments
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.offAllNamed("/location", arguments: tour);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.location_on, size: 16),
                            SizedBox(width: 4),
                            Text(tour.address), // Gunakan tour.address
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  // Rating
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 16),
                      SizedBox(width: 4),
                      Text(
                          '${tour.address} (${tour.review} Reviews)'), // Use rating and review count
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Amenities
                  const Text('Amenities',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List<Widget>.generate(
                      tour.amenities.length,
                      (index) => _buildChip(tour.amenities[index].data),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Self Check-in and Clean Accommodation
                  _buildInfoRow(Icons.phone_android, 'Self Check-in',
                      'Check yourself in with our mobile app'),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.cleaning_services, 'Clean Accommodation',
                      'CHSE-certified accommodations for applying hygiene protocol'),
                  const SizedBox(height: 16),
                  // Price and Booking
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price starts from'),
                          Text(
                            'Rp ${tour.price}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(tour.days),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.offAllNamed("/CheckoutScreen");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                        ),
                        child: Text('Booking'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              width: Get.width * 0.8,
              child: Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
