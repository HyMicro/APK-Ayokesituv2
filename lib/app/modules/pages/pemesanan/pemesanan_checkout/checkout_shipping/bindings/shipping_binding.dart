import 'package:get/get.dart';

import '../controllers/shipping_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckoutController());
  }
}