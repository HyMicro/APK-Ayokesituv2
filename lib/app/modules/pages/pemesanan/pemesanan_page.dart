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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and location
                  Text(
                    tour.title,
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed("/location", arguments: tour);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 16, color: Colors.grey[700]),
                        SizedBox(width: 4),
                        Text(
                          tour.address,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Rating
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow[700], size: 16),
                      SizedBox(width: 4),
                      Text(
                        '${tour.ratting} (${tour.review} Reviews)',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Amenities
                  const Text('Amenities',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List<Widget>.generate(
                      tour.amenities.length,
                      (index) => _buildAmenityChip(tour.amenities[index].data),
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
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Price starts from',
                                style: TextStyle(fontSize: 14)),
                            const SizedBox(height: 4),
                            Text(
                              'Rp ${tour.price}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tour.days,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
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
                          child: const Text('Booking'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmenityChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2), // memberikan efek shadow di bawah
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey[700]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
