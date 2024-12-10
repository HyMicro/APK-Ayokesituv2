import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class CheckoutController extends GetxController {
  // Variables to hold user inputs
  var selectedPaymentMethod = ''.obs;
  var creditCardText = ''.obs;
  var nameText = ''.obs;
  var expirationDateText = ''.obs;
  var cvvText = ''.obs;
  var isBillingSameAsShipping = false.obs;

  final CollectionReference reference =
      FirebaseFirestore.instance.collection("tiket");

  RxList<Map<String, dynamic>> bookingsList = <Map<String, dynamic>>[].obs;

  final stt.SpeechToText _speech = stt.SpeechToText();

  var isListening = false.obs;
  var text = "".obs;

  @override
  void onInit() {
    super.onInit();
    _initSpeech();
    // No need to add listeners for RxString values as they update reactively.
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _initSpeech() async {
    try {
      bool available = await _speech.initialize(onStatus: (status) {
        print('Speech status: $status');
      }, onError: (error) {
        print('Speech error: $error');
      });

      if (available) {
        print('Speech recognition initialized');
      } else {
        print('Speech recognition not available');
      }
    } catch (e) {
      print('Error initializing speech: $e');
    }
  }

  Future<void> checkMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      var result = await Permission.microphone.request();
      if (result.isDenied || result.isPermanentlyDenied) {
        Get.snackbar("Permission Denied", "Microphone permission is required.");
        return;
      }
    }
  }

  Future<void> startListening(RxString textRx) async {
    await checkMicrophonePermission();

    if (await Permission.microphone.isGranted) {
      isListening.value = true;
      await _speech.listen(
        onResult: (result) {
          if (result.hasConfidenceRating && result.confidence > 0.5) {
            // Update the RxString with recognized words
            textRx.value = result.recognizedWords;
          }
        },
        onSoundLevelChange: (level) => print('Sound level: $level'),
      );
    } else {
      print("Microphone permission denied.");
    }
  }

  // Menghentikan proses pengenalan suara
  void stopListening() async {
    isListening.value = false;
    await _speech.stop();
  }

  // Method to select payment method
  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  // Form validation method
  bool validateForm() {
    return selectedPaymentMethod.value.isNotEmpty &&
        creditCardText.value.isNotEmpty &&
        nameText.value.isNotEmpty &&
        expirationDateText.value.isNotEmpty &&
        cvvText.value.isNotEmpty;
  }

  // Confirm button logic
  void onConfirm() {
    final bookingData = {
      'credit_card': creditCardText.value,
      'cvv': cvvText.value,
      'expiration_date': expirationDateText.value,
      'name': nameText.value,
      'payment_method': selectedPaymentMethod.value,
      'is_billing_same_as_shipping': isBillingSameAsShipping.value,
      'bookingDate': Timestamp.now(),
      'status': 'booked',
    };
    addBooking(bookingData);
    Get.snackbar("Success", "Payment processed successfully");
  }

  void _validateForm() {
    update(); // To trigger UI update in GetX
  }

  // Add a new booking
  Future<void> addBooking(Map<String, dynamic> bookingData) async {
    try {
      await reference.add(bookingData);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add booking: $e');
    }
  }

  // Update an existing booking
  Future<void> updateBooking(
      String bookingId, Map<String, dynamic> bookingData) async {
    try {
      await reference.doc(bookingId).update(bookingData);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update booking: $e');
    }
  }

  // Delete a booking
  Future<void> deleteBooking(String bookingId) async {
    try {
      await reference.doc(bookingId).delete();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete booking: $e');
    }
  }
}
