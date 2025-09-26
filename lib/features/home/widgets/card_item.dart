import 'package:flutter/material.dart';
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
    return Card(
      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.grey.shade500,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, width: 185),
            Gap(10),
            CustomText(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              text: description,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            Gap(10),
            CustomText(text: '⭐ $rating'),
          ],
        ),
      ),
    );
  }
}
