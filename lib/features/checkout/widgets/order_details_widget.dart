import 'package:flutter/material.dart';
import 'package:food_app/shared/custom_text.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key,
    required this.order,
    required this.taxes,
    required this.deliveryFees,
    required this.total,
  });
  final String order;
  final String taxes;
  final String deliveryFees;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: checkoutWidget(
            text: 'Order',
            price: order,
            isBold: false,
            color: Colors.grey.shade500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: checkoutWidget(
            text: 'Taxes',
            price: taxes,
            isBold: false,
            color: Colors.grey.shade500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: checkoutWidget(
            text: 'Delivery fees',
            price: deliveryFees,
            isBold: false,
            color: Colors.grey.shade500,
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: checkoutWidget(
            text: 'Total',
            price: total,
            isBold: true,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: checkoutWidget(
            text: 'Estimated delivery time:',
            price: '15 - 30 mins',
            isBold: true,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

Widget checkoutWidget({
  required String text,
  required String price,
  required bool isBold,
  required Color color,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        text: text,
        fontSize: 18,
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
      ),
      CustomText(
        text: price,
        fontSize: 18,
        color: color,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
      ),
    ],
  );
}
