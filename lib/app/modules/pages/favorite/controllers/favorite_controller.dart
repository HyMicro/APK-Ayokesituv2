import 'package:get/get.dart';

import '../../../../data/models/resort_fav_model.dart';

class FavoriteController extends GetxController {
  // List of favorite items
  var favoriteList = <ResortFavModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load initial data for favorites
    loadFavorites();
  }

  void loadFavorites() {
    // Example data for favorite items
    favoriteList.addAll([
      ResortFavModel(
        title: "Sumba Island",
        price: 196.46,
        rating: 4.9,
        description: "A resort is a place used for vacation, relaxation or as day...",
        imageUrl: 'https://example.com/sumba-island.jpg',
      ),
      // Add more items as needed
    ]);
  }

  void toggleFavorite(ResortFavModel item) {
    // Toggle favorite status
    if (favoriteList.contains(item)) {
      favoriteList.remove(item);
    } else {
      favoriteList.add(item);
    }
  }
}
