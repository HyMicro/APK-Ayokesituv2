import 'package:get/get.dart';

class SearchController extends GetxController {
  final searchQuery = ''.obs;
  final selectedCategories = <String>[].obs;
  final favorites = <String>{}.obs;
  
  final categories = [
    {'icon': '🏖️', 'name': 'Beach'},
    {'icon': '🏔️', 'name': 'Mountain'},
    {'icon': '🌲', 'name': 'Forest'},
    {'icon': '🏄', 'name': 'Ride'},
  ];

  final destinations = [
    {
      'id': '1',
      'name': 'Sumba Island',
      'price': 196.46,
      'rating': 4.9,
      'image': 'assets/jpg/sumba_island.jpg',
      'description': 'A resort is a place used for vacation, ralaxation or as day....',
    },
    // Add more destinations here
  ].obs;

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

  void updateSearch(String query) {
    searchQuery.value = query;
  }
}