import 'package:flutter/material.dart';
import 'package:food_app/features/product/widgets/spicy_slider.dart';
import 'package:food_app/features/product/widgets/topping_card.dart';
import 'package:food_app/shared/custom_button.dart';
import 'package:food_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double spicyValue = 0.7;
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
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpicySlider(
                value: spicyValue,
                onChanged: (value) {
                  setState(() {
                    spicyValue = value;
                  });
                },
              ),
              Gap(50),
              CustomText(
                text: 'Toppings',
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              Gap(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    6,
                    (index) => ToppingCard(
                      imageUrl: 'assets/test/tomato.png',
                      title: 'Tomato',
                      onAdd: () {},
                    ),
                  ),
                ),
              ),
              Gap(30),
              CustomText(
                text: 'Side Options',
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              Gap(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    6,
                    (index) => ToppingCard(
                      imageUrl: 'assets/test/fries.png',
                      title: 'Fries',
                      onAdd: () {},
                    ),
                  ),
                ),
              ),
              Gap(30),
              Row(
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
                  CustomButton(text: 'Add to Cart', onTap: () {}),
                ],
              ),
              Gap(100),
            ],
          ),
        ),
      ),
    );
  }
}
