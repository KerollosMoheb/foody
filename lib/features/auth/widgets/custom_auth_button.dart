import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/shared/custom_text.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.text,
    this.onTap,
    this.color,
    this.textColor,
  });
  final String text;
  final Function()? onTap;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.grey),
        ),
        width: double.infinity,
        child: Center(
          child: CustomText(
            text: text,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: textColor ?? AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
