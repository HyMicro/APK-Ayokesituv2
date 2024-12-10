import 'package:ayokesituv2/app/modules/pages/order/controller/order_controller.dart';
import 'package:get/get.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
  }
}
