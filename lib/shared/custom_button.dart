import 'package:flutter/material.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.color,
    this.height,
    this.textColor,
    this.radius,
    this.widget,
    this.gap,
  });
  final String text;
  final Function()? onTap;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final double? radius;
  final Widget? widget;
  final double? gap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 50,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: text,
              color: textColor ?? Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            Gap(gap ?? 0.0),
            widget ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
