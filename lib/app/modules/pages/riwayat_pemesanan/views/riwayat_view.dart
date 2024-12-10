// import 'package:flutter/material.dart';
// import 'controller.dart'; // Import your controller

// class ResortCard extends StatelessWidget {
//   final ResortController controller;

//   ResortCard({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Card(
//           child: Column(
//             children: [
//               Image.network(controller.resort.imageUrl),
//               ListTile(
//                 title: Text(controller.resort.name),
//                 subtitle: Text(controller.resort.description),
//                 trailing: Icon(Icons.favorite_border),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("\$${controller.resort.price.toStringAsFixed(2)}"),
//                     Row(
//                       children: [
//                         Icon(Icons.star, color: Colors.amber),
//                         Text(controller.resort.rating.toString()),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               // Rating Button
//               ElevatedButton(
//                 onPressed: controller.giveRating,
//                 child: Text("Berikan Ratingmu!"),
//               ),
//               // Review Button
//               ElevatedButton(
//                 onPressed: controller.writeReview,
//                 child: Text("Tulis Ulasanmu!"),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
