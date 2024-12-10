import 'package:get/get.dart';

class PaymentSuccessBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentSuccessBinding());
  }
}