// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SearchView extends GetView<SearchController> {
//   const SearchView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             _buildSearchBar(),
//             _buildCategories(),
//             _buildDestinationList(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () => Get.back(),
//             style: IconButton.styleFrom(
//               backgroundColor: Colors.white,
//               shape: const CircleBorder(),
//               elevation: 2,
//             ),
//           ),
//           const Text(
//             'Search',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.filter_list),
//             onPressed: () {},
//             style: IconButton.styleFrom(
//               backgroundColor: Colors.white,
//               shape: const CircleBorder(),
//               elevation: 2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: TextField(
//         onChanged: controller.updateSearch,
//         decoration: InputDecoration(
//           hintText: 'Search destination',
//           prefixIcon: const Icon(Icons.search, color: Colors.grey),
//           filled: true,
//           fillColor: Colors.grey[100],
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         ),
//       ),
//     );
//   }

//   Widget _buildCategories() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       padding: const EdgeInsets.all(16),
//       child: Obx(() => Row(
//         children: controller.categories.map((category) {
//           final isSelected = controller.selectedCategories.contains(category['name']);
//           return Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: FilterChip(
//               label: Row(
//                 children: [
//                   Text(category['icon']!),
//                   const SizedBox(width: 4),
//                   Text(category['name']!),
//                 ],
//               ),
//               selected: isSelected,
//               onSelected: (_) => controller.toggleCategory(category['name']!),
//               backgroundColor: Colors.white,
//               selectedColor: Colors.green,
//               labelStyle: TextStyle(
//                 color: isSelected ? Colors.white : Colors.black,
//                 fontWeight: FontWeight.w500,
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 side: BorderSide(
//                   color: isSelected ? Colors.green : Colors.grey[300]!,
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       )),
//     );
//   }

//   Widget _buildDestinationList() {
//     return Expanded(
//       child: Obx(() => ListView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: controller.destinations.length,
//         itemBuilder: (context, index) {
//           final destination = controller.destinations[index];
//           return _buildDestinationCard(destination);
//         },
//       )),
//     );
//   }

//   Widget _buildDestinationCard(Map<String, dynamic> destination) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                 child: Image.asset(
//                   destination['image']!,
//                   height: 150,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Positioned(
//                 top: 8,
//                 right: 8,
//                 child: Obx(() => IconButton(
//                   icon: Icon(
//                     controller.favorites.contains(destination['id'])
//                         ? Icons.favorite
//                         : Icons.favorite_border,
//                     color: Colors.white,
//                   ),
//                   onPressed: () => controller.toggleFavorite(destination['id']),
//                 )),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       destination['name']!,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       '\$${destination['price']}',
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Row(
//                       children: List.generate(
//                         5,
//                         (index) => Icon(
//                           Icons.star,
//                           size: 16,
//                           color: index < destination['rating'].floor()
//                               ? Colors.amber
//                               : Colors.grey[300],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       '${destination['rating']}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   destination['description']!,
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 12,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }