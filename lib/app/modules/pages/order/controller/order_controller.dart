import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrderController extends GetxController {
  final CollectionReference reference =
      FirebaseFirestore.instance.collection("tiket");

  RxList<Map<String, dynamic>> bookingsList = <Map<String, dynamic>>[].obs;

  // Instance of GetStorage for accessing local data
  final Connectivity _connectivity = Connectivity();
  final LocalController = GetStorage();
  var connectingInternet = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchBookingsFromFirestore();
    await fetchBookingsFromLocalStorage();

    _connectivity.onConnectivityChanged.listen((connectivityResults) {
      if (connectivityResults.first == ConnectivityResult.none)
        connectingInternet(false);
      else
        connectingInternet(true);
      update();
    });
  }

  // Fetch all bookings from Firestore
  Future<void> fetchBookingsFromFirestore() async {
    try {
      final querySnapshot = await reference.get();
      bookingsList.value = querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                ...doc.data() as Map<String, dynamic>,
              })
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch bookings from Firestore: $e');
    }
  }

  // Fetch bookings from local storage
  Future<void> fetchBookingsFromLocalStorage() async {
    try {
      final storedData = await LocalController.read('booking data');
      print("storedData $storedData");
      if (storedData != null) {
        final localData = {
          'id': 'local-1',
          ...Map<String, dynamic>.from(storedData),
          'source': 'local',
        };
        bookingsList.add(localData);
      }
    } catch (e) {
      print("Error reading local storage: $e");
      Get.snackbar('Error', 'Failed to fetch bookings from local storage: $e');
    }
  }

  // Update a booking
  Future<void> updateBooking(String id, Map<String, dynamic> newData) async {
    try {
      if (connectingInternet.value) {
        await reference.doc(id).update(newData);
        fetchBookingsFromFirestore();
      } else {
        // update local getstorage
        fetchBookingsFromLocalStorage();
      }

      Get.snackbar('Success', 'Booking updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update booking: $e');
    }
  }

  // Delete a booking
  Future<void> deleteBooking(String id) async {
    try {
      if (connectingInternet.value) {
        await reference.doc(id).delete();
        bookingsList.removeWhere((booking) => booking['id'] == id);
      } else {
        // delete local storage
        fetchBookingsFromLocalStorage();
      }

      Get.snackbar('Success', 'Booking deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete booking: $e');
    }
  }
}
