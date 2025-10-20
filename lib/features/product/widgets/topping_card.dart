import 'package:flutter/material.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

class ToppingCard extends StatelessWidget {
  const ToppingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onAdd,
  });
  final String imageUrl;
  final String title;
  final VoidCallback onAdd;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: 120,
            width: 100,
            color: AppColors.primaryColor,
          ),
        ),

        // Image section
        Positioned(
          top: -10,
          right: -1,
          left: -1,
          child: SizedBox(
            height: 70,
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              child: Image.asset(imageUrl, fit: BoxFit.contain),
            ),
          ),
        ),

        // bottom widgets
        Positioned(
          right: 0,
          left: 0,
          bottom: -5,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                CustomText(
                  text: title,
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),

                Gap(5),

                GestureDetector(
                  onTap: onAdd,
                  child: const CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.add, color: Colors.red, size: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
