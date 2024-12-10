import 'package:ayokesituv2/app/modules/pages/home/bindings/home_binding.dart';
import 'package:ayokesituv2/app/modules/pages/maps/bindings/location_binding.dart';
import 'package:ayokesituv2/app/modules/pages/maps/view/location.dart';
import 'package:ayokesituv2/app/modules/pages/order/binding/order_binding.dart';
import 'package:ayokesituv2/app/modules/pages/order/view/order_view.dart';
import 'package:ayokesituv2/app/modules/pages/pemesanan/pemesanan_page.dart';
import 'package:ayokesituv2/app/modules/pages/profile/profile_page.dart';
import 'package:get/get.dart';

import '../modules/pages/home/views/homepage_view.dart';
// import '../modules/pages/maps/location.dart';
import '../modules/pages/pemesanan/pemesanan_checkout/checkout_payment/bindings/checkout_binding.dart';
import '../modules/pages/pemesanan/pemesanan_checkout/checkout_payment/views/chechout_view.dart';
import '../modules/pages/pemesanan/pemesanan_success/binding/success_binding.dart';
import '../modules/pages/pemesanan/pemesanan_success/views/success_view.dart';
import '../modules/pages/profile/edit profile/edit_profile.dart';
import 'onboarding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ), // In app_pages.dart
    GetPage(
      name: Routes.PAYMENT,
      page: () => const PemesananPage(),
    ),
    GetPage(
      name: Routes.PEMESANAN,
      page: () => PemesananPage(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const onboardings(),
    ),
    GetPage(
      name: Routes.PAYMENT_SUCCESS,
      page: () => SuccessView(),
      binding: PaymentSuccessBinding(),
    ),
    GetPage(
      name: Routes.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: Routes.ORDER,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: Routes.PROFILE_EDIT,
      page: () => EditProfilePage(),
    ),
    GetPage(
      name: Routes.LOCATION,
      page: () => Location(),
      binding: LocationBinding(),
    )
  ];
}
