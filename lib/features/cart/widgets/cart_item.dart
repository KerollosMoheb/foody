import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/shared/custom_button.dart';
import 'package:food_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.onAdd,
    this.onMinus,
    this.onRemove,
    required this.quantity,
  });
  final String image;
  final String title;
  final String description;
  final Function()? onAdd;
  final Function()? onMinus;
  final Function()? onRemove;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.grey.shade500,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Column(
              children: [
                Image.asset(image, height: 100),
                CustomText(
                  text: title,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text: description,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            Spacer(),
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onMinus,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(CupertinoIcons.minus, color: Colors.white),
                      ),
                    ),
                    Gap(30),
                    CustomText(
                      text: quantity.toString(),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    Gap(30),
                    GestureDetector(
                      onTap: onAdd,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(CupertinoIcons.plus, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Gap(30),
                CustomButton(text: 'Remove', onTap: onRemove),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
