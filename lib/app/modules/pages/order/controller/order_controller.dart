import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final CollectionReference reference =
      FirebaseFirestore.instance.collection("tiket");

  RxList<Map<String, dynamic>> bookingsList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  // Fetch all bookings
  Future<void> fetchBookings() async {
    try {
      final querySnapshot = await reference.get();
      bookingsList.value = querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                ...doc.data() as Map<String, dynamic>,
              })
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch bookings: $e');
    }
  }

  // Update a booking
  Future<void> updateBooking(String id, Map<String, dynamic> newData) async {
    try {
      await reference.doc(id).update(newData);
      fetchBookings();
      Get.snackbar('Success', 'Booking updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update booking: $e');
    }
  }

  // Delete a booking
  Future<void> deleteBooking(String id) async {
    try {
      await reference.doc(id).delete();
      bookingsList.removeWhere((booking) => booking['id'] == id);
      Get.snackbar('Success', 'Booking deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete booking: $e');
    }
  }
}
