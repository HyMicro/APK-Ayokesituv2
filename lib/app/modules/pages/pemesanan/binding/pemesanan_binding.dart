import 'package:ayokesituv2/app/modules/pages/pemesanan/controller/pemesanan_controller.dart';
import 'package:get/get.dart';

class PemesananBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PemesananController());
  }
}
