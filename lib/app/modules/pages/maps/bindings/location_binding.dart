import 'package:ayokesituv2/app/modules/pages/maps/controllers/location_controller.dart';
import 'package:get/get.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationController());
  }
}