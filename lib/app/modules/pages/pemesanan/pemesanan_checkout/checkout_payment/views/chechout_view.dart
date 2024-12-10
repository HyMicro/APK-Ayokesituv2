import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offNamed("/home");
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step indicator
            Row(
              children: [
                StepIndicator(stepNumber: 1, label: "Shipping"),
                StepIndicator(stepNumber: 2, label: "Payment", isActive: false),
              ],
            ),
            SizedBox(height: 20),

            // Payment Method Selection
            Text("Select a payment method"),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PaymentMethodButton(
                      label: "Visa",
                      isSelected:
                          controller.selectedPaymentMethod.value == 'Visa',
                      onTap: () => controller.selectPaymentMethod('Visa'),
                    ),
                    PaymentMethodButton(
                      label: "PayPal",
                      isSelected:
                          controller.selectedPaymentMethod.value == 'PayPal',
                      onTap: () => controller.selectPaymentMethod('PayPal'),
                    ),
                    PaymentMethodButton(
                      label: "Dana",
                      isSelected:
                          controller.selectedPaymentMethod.value == 'Dana',
                      onTap: () => controller.selectPaymentMethod('Dana'),
                    ),
                    PaymentMethodButton(
                      label: "QRIS",
                      isSelected:
                          controller.selectedPaymentMethod.value == 'QRIS',
                      onTap: () => controller.selectPaymentMethod('QRIS'),
                    ),
                  ],
                )),
            SizedBox(height: 20),
            buildSpeechToTextTextField(
              controller.creditCardText,
              'Credit Card',
            ),
            buildSpeechToTextTextField(
              controller.nameText,
              'Name',
            ),
            Row(
              children: [
                Expanded(
                  child: buildSpeechToTextTextField(
                    controller.expirationDateText,
                    'Expiration Date',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: buildSpeechToTextTextField(
                    controller.cvvText,
                    'CVV',
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Billing Address Checkbox
            Obx(
              () => Row(
                children: [
                  Checkbox(
                    value: controller.isBillingSameAsShipping.value,
                    onChanged: (value) {
                      controller.isBillingSameAsShipping.value = value ?? false;
                    },
                  ),
                  Expanded(
                    child: Text(
                      "My billing address is the same as my shipping address.",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.onConfirm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Confirm'),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSpeechToTextTextField(RxString textRx, String label) {
    return Obx(() {
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: textRx.value,
              decoration: InputDecoration(labelText: label),
              onChanged: (value) {
                textRx.value = value; // Update the RxString when the user types
              },
            ),
          ),
          IconButton(
            icon:
                Icon(controller.isListening.value ? Icons.mic : Icons.mic_none),
            onPressed: () {
              if (controller.isListening.value) {
                controller.stopListening();
              } else {
                controller.startListening(textRx);
              }
            },
          ),
        ],
      );
    });
  }
}

class StepIndicator extends StatelessWidget {
  final int stepNumber;
  final String label;
  final bool isActive;

  const StepIndicator(
      {super.key,
      required this.stepNumber,
      required this.label,
      this.isActive = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: isActive ? Colors.blue : Colors.grey,
          child: Text(
            '$stepNumber',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Text(
          label,
          style: TextStyle(color: isActive ? Colors.black : Colors.grey),
        ),
      ],
    );
  }
}

class PaymentMethodButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodButton(
      {super.key,
      required this.label,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
