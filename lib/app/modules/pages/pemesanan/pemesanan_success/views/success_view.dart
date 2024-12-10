import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/success_controller.dart';

class SuccessView extends GetView<SuccessController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Success icon
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Icon(Icons.check, color: Colors.white, size: 60),
              ),
              SizedBox(height: 20),

              // Success message
              Text(
                "Payment Successful",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "successfully paid ${controller.amount} to AyoKesitu",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Divider(height: 40, thickness: 1, color: Colors.grey[300]),

              // Transaction details
              DetailRow(label: "Transaction Number", value: controller.transactionNumber),
              DetailRow(label: "Date", value: controller.transactionDate),
              DetailRow(label: "Status", value: controller.status, isStatus: true),
              DetailRow(label: "Type of Transactions", value: controller.paymentMethod),
              DetailRow(label: "Nominal", value: controller.amount),
              SizedBox(height: 20),

              // Total amount
              Text(
                controller.amount,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 30),

              // Continue button
              ElevatedButton(
                onPressed: () {
                  // Define what happens on pressing Continue, e.g., navigate back to the main screen
                  Get.offAllNamed('/home');
                },
                child: Text("Continue"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget to show transaction details in a row format
class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isStatus;

  DetailRow({required this.label, required this.value, this.isStatus = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey)),
          if (isStatus)
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Icon(Icons.check, color: Colors.green, size: 16),
                  SizedBox(width: 5),
                  Text(value, style: TextStyle(color: Colors.green)),
                ],
              ),
            )
          else
            Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
