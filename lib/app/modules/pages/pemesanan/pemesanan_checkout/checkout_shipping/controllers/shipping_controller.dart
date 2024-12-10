import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final selectedPaymentMethod = ''.obs;
  final creditCardNumber = ''.obs;
  final cardHolderName = ''.obs;
  final expirationDate = ''.obs;
  final cvv = ''.obs;
  final sameAsShipping = false.obs;
  final currentStep = 1.obs;

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void updateCreditCard(String value) {
    creditCardNumber.value = value;
  }

  void updateName(String value) {
    cardHolderName.value = value;
  }

  void updateExpiration(String value) {
    expirationDate.value = value;
  }

  void updateCVV(String value) {
    cvv.value = value;
  }

  void toggleSameAsShipping() {
    sameAsShipping.value = !sameAsShipping.value;
  }

  bool validateForm() {
    // Add validation logic here
    return creditCardNumber.value.isNotEmpty &&
        cardHolderName.value.isNotEmpty &&
        expirationDate.value.isNotEmpty &&
        cvv.value.isNotEmpty;
  }

  void onConfirm() {
    if (validateForm()) {
      // Handle form submission
      Get.toNamed('/payment-success');
    }
  }
}