import 'package:ayokesituv2/app/modules/pages/order/widget/order_detail_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ayokesituv2/app/modules/pages/order/controller/order_controller.dart';
import 'package:intl/intl.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offNamed("/profile");
          },
        ),
      ),
      body: Obx(() {
        if (controller.bookingsList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: controller.bookingsList.length,
          itemBuilder: (context, index) {
            final booking = controller.bookingsList[index];
            return OrderDetailCard(
              bookingData: booking,
              onEdit: () {
                _showEditDialog(context, booking);
              },
              onDelete: () {
                _showDeleteConfirmationDialog(context, booking['id']);
              },
            );
          },
        );
      }),
    );
  }

  void _showEditDialog(BuildContext context, Map<String, dynamic> booking) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    final TextEditingController nameController =
        TextEditingController(text: booking['name']);
    final TextEditingController bookingDateController = TextEditingController(
      text: booking['bookingDate'] is Timestamp
          ? dateFormat.format(booking['bookingDate'].toDate())
          : booking['bookingDate'],
    );
    final TextEditingController paymentMethodController =
        TextEditingController(text: booking['payment_method']);
    final TextEditingController creditCardController =
        TextEditingController(text: booking['credit_card']);
    final TextEditingController cvvController =
        TextEditingController(text: booking['cvv']);
    final TextEditingController expirationDateController =
        TextEditingController(text: booking['expiration_date']);

    Get.defaultDialog(
      title: "Edit Booking",
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: bookingDateController,
            decoration: const InputDecoration(labelText: 'Booking Date'),
          ),
          TextField(
            controller: paymentMethodController,
            decoration: const InputDecoration(labelText: 'Payment Method'),
          ),
          TextField(
            controller: creditCardController,
            decoration: const InputDecoration(labelText: 'Credit Card'),
          ),
          TextField(
            controller: cvvController,
            decoration: const InputDecoration(labelText: 'CVV'),
          ),
          TextField(
            controller: expirationDateController,
            decoration: const InputDecoration(labelText: 'Expiration Date'),
          ),
        ],
      ),
      textConfirm: "Save",
      textCancel: "Cancel",
      onConfirm: () {
        final updatedData = {
          'name': nameController.text,
          'bookingDate': Timestamp.fromDate(
              DateFormat('yyyy-MM-dd').parse(bookingDateController.text)),
          'payment_method': paymentMethodController.text,
          'credit_card': creditCardController.text,
          'cvv': cvvController.text,
          'expiration_date': expirationDateController.text,
        };

        controller.updateBooking(booking['id'], updatedData);
        Get.back();
      },
      onCancel: () {},
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String bookingId) {
    Get.defaultDialog(
      title: "Delete Booking",
      middleText: "Are you sure you want to delete this booking?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.deleteBooking(bookingId);
        Get.back();
      },
      onCancel: () {},
    );
  }
}
