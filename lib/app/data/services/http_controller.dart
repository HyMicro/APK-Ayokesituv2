import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class serviceNetwork extends GetxController {
  // RxList<Tour> tour = RxList<Tour>([]);
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    await fetchTours();
    super.onInit();
  }

  Future<List<Tour>> fetchTours() async {
    final String response = await rootBundle
        .loadString('assets/json/tours.json'); // Path to your JSON file
    final Map<String, dynamic> data = json.decode(response);

    return List<Tour>.from(data['data'].map((item) => Tour.fromJson(item)));
    // try {
    //   isLoading.value = true;
    //   final response =
    //       await http.get(Uri.parse('https://pastebin.com/raw/qGVXsga6'));

    //   if (response.statusCode == 200) {
    //     final jsonData = response.body;
    //     // print(jsonData);
    //     final toursResults = Tours.fromJson(json.decode(jsonData));
    //     return toursResults;
    //   } else {
    //     throw Exception('Request failed with status: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   throw Exception('Request failed with status: ${e}');
    // } finally {
    //   isLoading.value = false;
    // }
  }
}
