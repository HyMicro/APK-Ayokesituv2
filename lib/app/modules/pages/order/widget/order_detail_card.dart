import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderDetailCard extends GetView {
  final Map<String, dynamic> bookingData;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const OrderDetailCard({
    super.key,
    required this.bookingData,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Format the booking date if it's a DateTime
    final String bookingDate = bookingData['bookingDate'] is DateTime
        ? DateFormat('yyyy-MM-dd').format(bookingData['bookingDate'])
        : bookingData['bookingDate'].toString();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildInfoList([
              {'label': 'Name', 'value': bookingData['name']},
              {'label': 'Booking Date', 'value': bookingDate},
              {'label': 'Payment Method', 'value': bookingData['payment_method']},
              {'label': 'Credit Card', 'value': bookingData['credit_card']},
              {'label': 'CVV', 'value': bookingData['cvv']},
              {'label': 'Expiration Date', 'value': bookingData['expiration_date']},
              {
                'label': 'Billing Same as Shipping',
                'value': bookingData['is_billing_same_as_shipping'].toString(),
              },
              {'label': 'Status', 'value': bookingData['status']},
            ]),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: onEdit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: onDelete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildInfoList(List<Map<String, String>> infoList) {
    return infoList
        .map((info) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${info['label']}: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      info['value'] ?? '-',
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ))
        .toList();
  }
}
