import 'dart:convert';

import 'package:ayokesituv2/app/data/models/article_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../data/services/http_controller.dart';

class HomeController extends GetxController {
  final searchQuery = ''.obs;
  final selectedCategories = <String>[].obs;
  final favorites = <String>{}.obs;
  final tours = <Tour>[].obs;

  final serviceNetwork _serviceNetwork = serviceNetwork();

  @override
  void onInit() {
    super.onInit();
    loadTourData();
  }

  final categories = [
    {'icon': '🏖️', 'name': 'Beach'},
    {'icon': '🏔️', 'name': 'Mountain'},
    {'icon': '🌲', 'name': 'Forest'},
    {'icon': '🏄', 'name': 'Ride'},
  ];

  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
  }

  Future<void> loadTourData() async {
    const url =
        'https://raw.githubusercontent.com/HyMicro/Ayokesituv2/refs/heads/main/tour.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        final loadedTours = data.map((tour) => Tour.fromJson(tour)).toList();
        tours.assignAll(loadedTours); // Update observable list
      } else {
        print('Failed to fetch tours: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to load tours: $e');
    }
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  // Filtered list of tour images for display
  List<String> get tourImages {
    return tours.map((tour) => tour.img).toList();
  }
}
