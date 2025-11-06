import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/core/constants/app_colors.dart';
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
    required this.number,
    required this.isLoading,
  });
  final String image;
  final String title;
  final String description;
  final Function()? onAdd;
  final Function()? onMinus;
  final Function()? onRemove;
  final int number;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(image, width: 80),
                CustomText(
                  text: title,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                CustomText(text: description, fontSize: 13),
              ],
            ),
          ),

          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: onAdd,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(
                        CupertinoIcons.add,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                  Gap(20),
                  CustomText(
                    text: number.toString(),
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                  Gap(20),
                  GestureDetector(
                    onTap: onMinus,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(
                        CupertinoIcons.minus,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(20),
              GestureDetector(
                onTap: onRemove,
                child: Container(
                  height: 40,
                  width: 130,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: isLoading
                      ? CupertinoActivityIndicator(color: Colors.white)
                      : Center(
                          child: CustomText(
                            text: 'Remove',
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
