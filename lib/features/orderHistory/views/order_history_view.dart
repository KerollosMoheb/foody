import 'package:flutter/material.dart';
import 'package:food_app/shared/custom_button.dart';
import 'package:food_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 100),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              elevation: 3,
              shadowColor: Colors.grey.shade500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/test/hamburger.png', height: 100),
                        Column(
                          children: [
                            CustomText(
                              text: 'Hamburger',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              text: 'Veggi Burger',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            CustomText(
                              text: 'Qty: 10',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            CustomText(
                              text: '\$10.00',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Gap(20),
                    CustomButton(text: 'Reorder', width: double.infinity),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
