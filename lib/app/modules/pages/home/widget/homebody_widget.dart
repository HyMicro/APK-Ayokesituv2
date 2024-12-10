import 'package:ayokesituv2/app/modules/pages/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'searchbar_widget.dart';

class HomeScreenBody extends GetView<HomeController> {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 30),
          const SearchBarWidget(),
          const SizedBox(height: 20),
          // Section for Recommended
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recommended",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Handle explore action
                },
                child: Text(
                  "Explore",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Horizontal list of recommended items
          SizedBox(
            height: 200, // Fixed height for horizontal list
            child: Obx(() {
              return ListView.builder(
                scrollDirection: Axis.horizontal, // Horizontal scrolling
                itemCount: controller.tours.length,
                itemBuilder: (context, index) {
                  final tour = controller.tours[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                        right: 16.0), // Add spacing between items
                    child: GestureDetector(
                      onTap: () {
                        Get.offNamed('/pemesanan_view', arguments: tour);
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: SizedBox(
                          width: 150, // Width of each item
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12.0),
                                ),
                                child: Image.asset(
                                  tour.img,
                                  height: 100, // Image height
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tour.title,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      tour.address,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.amber, size: 14),
                                        SizedBox(width: 4),
                                        Text(
                                          tour.ratting,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 20),
          // Section for Popular Activities
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular Activities",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Handle see all action
                },
                child: Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Placeholder list for popular activities
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5, // Example item count
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(
                    'https://www.shutterstock.com/image-vector/flat-design-404-error-page-260nw-2489201787.jpg'),
                title: Text("Sumba Island"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("\$196.46"),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text("4.9"),
                      ],
                    ),
                  ],
                ),
                trailing: Icon(Icons.favorite_border),
              );
            },
          ),
        ],
      ),
    );
  }
}
