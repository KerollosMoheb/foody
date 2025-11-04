import 'package:flutter/material.dart';
import 'package:food_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

class ToppingCard extends StatelessWidget {
  const ToppingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onAdd,
    required this.color,
  });
  final String imageUrl;
  final String title;
  final VoidCallback onAdd;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: color,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    width: 80,
                    height: 50,
                  ),

                  Gap(10),

                  CustomText(
                    text: title,
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),

                  Gap(5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
