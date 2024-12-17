import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offNamed("/home");
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StepIndicator(stepNumber: 1, label: "Shipping"),
                  Expanded(
                    child: Divider(
                      color: Colors.blue,
                      thickness: 2,
                    ),
                  ),
                  StepIndicator(stepNumber: 2, label: "Payment", isActive: false),
                ],
              ),
              const SizedBox(height: 24),

              // Payment Method Selection
              const Text(
                "Select a payment method",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Please select a payment method most convenient to you.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              const SizedBox(height: 24),

              // Form Input Fields
              buildSpeechToTextTextField(
                controller.creditCardText,
                'Credit Card',
              ),
              const SizedBox(height: 16),
              buildSpeechToTextTextField(
                controller.nameText,
                'Name',
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: buildSpeechToTextTextField(
                      controller.expirationDateText,
                      'Expiration Date',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: buildSpeechToTextTextField(
                      controller.cvvText,
                      'CVV',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Billing Address Checkbox
              Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: controller.isBillingSameAsShipping.value,
                      onChanged: (value) {
                        controller.isBillingSameAsShipping.value = value ?? false;
                      },
                    ),
                    const Expanded(
                      child: Text(
                        "My billing address is the same as my shipping address.",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Confirm Button
              ElevatedButton(
                onPressed: () {
                  controller.onConfirm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
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
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                textRx.value = value;
              },
            ),
          ),
          IconButton(
            icon: Icon(
              controller.isListening.value ? Icons.mic : Icons.mic_none,
              color: controller.isListening.value ? Colors.blue : Colors.grey,
            ),
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

  const StepIndicator({
    super.key,
    required this.stepNumber,
    required this.label,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: isActive ? Colors.blue : Colors.grey,
          radius: 16,
          child: Text(
            '$stepNumber',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class PaymentMethodButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
