import 'package:flutter/material.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

class SpicySlider extends StatelessWidget {
  const SpicySlider({super.key, required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/detail/sandwich_detail.png', height: 300),
        Spacer(),
        Column(
          children: [
            CustomText(
              text:
                  'Customize Your Burger \n to Your Tastes.\n  Ultimate Experience',
            ),
            Slider(
              min: 0,
              max: 1,
              value: value,
              onChanged: onChanged,
              inactiveColor: Colors.grey.shade300,
              activeColor: AppColors.primaryColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: '🥶'),
                Gap(120),
                CustomText(text: '🌶️'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
