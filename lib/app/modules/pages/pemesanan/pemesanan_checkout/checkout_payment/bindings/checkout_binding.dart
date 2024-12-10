import 'package:get/get.dart';
import '../controllers/checkout_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    // Lazily initialize CheckoutController when the view is accessed
    Get.lazyPut<CheckoutController>(() => CheckoutController());
  }
}
