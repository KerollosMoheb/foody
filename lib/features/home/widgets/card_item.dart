import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.rating,
  });
  final String image;
  final String title;
  final String description;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 500),
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.purple.withAlpha(450).withOpacity(0.3),
            gradient: LinearGradient(
              colors: [
                Colors.grey.shade500,
                Colors.grey.shade300,
                Colors.grey.shade300,
                Colors.grey.shade300,
                Colors.grey.shade300,
                Colors.grey.shade300,
                Colors.grey.shade500,
                // AppColors.primaryColor,
                // AppColors.primaryColor,
                // AppColors.primaryColor.withOpacity(0.9),
                // AppColors.primaryColor.withOpacity(0.9),
                // AppColors.primaryColor.withOpacity(0.9),
                // AppColors.primaryColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: -4,
                      right: 10,
                      left: 10,
                      child: Image.asset(
                        'assets/icon/shadow.png',
                        color: Colors.black26,
                      ),
                    ),
                    Center(
                      child: Image.network(image, width: 130, height: 135),
                    ),
                  ],
                ),
                Gap(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: title,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppColors.primaryColor,
                      ),
                      CustomText(
                        text: description,
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.star_fill,
                            size: 16,
                            color: Colors.amber,
                          ),
                          Gap(6),
                          CustomText(
                            text: rating,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                          Spacer(),
                          Icon(
                            CupertinoIcons.heart,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
