import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationController extends GetxController {
  // Lokasi Sumba Island
  final LatLng location = const LatLng(-9.6500, 120.2700);
  Position? currentPosition;

  late GoogleMapController mapController;
  late bool serviceEnabled;
  late LocationPermission permission;

  // Fungsi untuk menginisialisasi map controller
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Fungsi untuk membuka lokasi di Google Maps
  Future<void> openInGoogleMaps() async {
    final url =
        'https://maps.app.goo.gl/Vt2kjsUvDJGHgKhh8=${location.latitude},${location.longitude}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Fungsi untuk membuka lokasi saat ini di Google Maps
  void openGoogleMaps() {
    if (currentPosition != null) {
      final url =
          'https://www.google.com/maps?q=${currentPosition!.latitude},${currentPosition!.longitude}';
      launchURL(url);
    }
  }

  // Fungsi untuk meluncurkan URL
  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Fungsi untuk mendapatkan lokasi saat ini
  Future<void> getCurrentLocation() async {
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw Exception('Location service not enabled');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permission denied forever');
      }

      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      print(e);
    }
  }
}
