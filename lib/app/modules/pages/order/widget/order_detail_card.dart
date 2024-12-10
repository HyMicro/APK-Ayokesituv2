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
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Name', bookingData['name']),
            _buildInfoRow('Booking Date', bookingDate),
            _buildInfoRow('Payment Method', bookingData['payment_method']),
            _buildInfoRow('Credit Card', bookingData['credit_card']),
            _buildInfoRow('CVV', bookingData['cvv']),
            _buildInfoRow('Expiration Date', bookingData['expiration_date']),
            _buildInfoRow(
              'Billing Same as Shipping',
              bookingData['is_billing_same_as_shipping'].toString(),
            ),
            _buildInfoRow('Status', bookingData['status']),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onEdit,
                  child: const Text('Edit'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: onDelete,
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
