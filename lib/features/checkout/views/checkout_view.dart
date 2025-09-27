import 'package:flutter/material.dart';
import 'package:food_app/features/checkout/widgets/order_details_widget.dart';
import 'package:food_app/features/checkout/widgets/success_dialog.dart';
import 'package:food_app/shared/custom_button.dart';
import 'package:food_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedMethod = 'Cash';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Order summary',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              OrderDetailsWidget(
                order: '\$16.48',
                taxes: '\$0.3',
                deliveryFees: '\$1.5',
                total: '\$18.19',
              ),
              Gap(50),
              CustomText(
                text: 'Payment methods',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              Gap(20),
              ListTile(
                onTap: () {
                  setState(() {
                    selectedMethod = 'cash';
                  });
                },
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                tileColor: Color(0xff3C2F2F),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Image.asset('assets/icon/cash.png', width: 70),
                title: Text('Cash on delivery'),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'cash',
                  groupValue: selectedMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedMethod = value!;
                    });
                  },
                ),
              ),
              Gap(20),
              ListTile(
                onTap: () {
                  setState(() {
                    selectedMethod = 'Visa';
                  });
                },
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                tileColor: Colors.blue.shade500,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Image.asset('assets/icon/visa.png', width: 70),
                title: Text('Debit card'),
                subtitle: Text('3566 **** **** 0505'),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'Visa',
                  groupValue: selectedMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedMethod = value!;
                    });
                  },
                ),
              ),
              Gap(10),
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                    fillColor: WidgetStateProperty.all(Colors.red),
                  ),
                  CustomText(
                    text: 'Save card details for future payments',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff808080),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800,
              blurRadius: 15,
              offset: Offset(0, 0),
            ),
          ],
        ),
        height: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Total',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500,
                  ),
                  CustomText(text: '\$18.9', fontSize: 32),
                ],
              ),
              Spacer(),
              CustomButton(
                text: 'Pay Now',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (index) {
                      return SuccessDialog();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
