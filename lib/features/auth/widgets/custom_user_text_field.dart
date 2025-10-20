import 'package:flutter/material.dart';
import 'package:food_app/core/constants/app_colors.dart';

class CustomUserTextField extends StatelessWidget {
  const CustomUserTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.textInputType,
  });
  final TextEditingController controller;
  final String labelText;
  final TextInputType? textInputType;
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 20,
      controller: controller,
      keyboardType: textInputType,
      cursorColor: AppColors.primaryColor,
      style: TextStyle(color: AppColors.primaryColor, fontSize: 14),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        labelText: labelText,
        labelStyle: TextStyle(color: AppColors.primaryColor),
        hintStyle: TextStyle(color: AppColors.primaryColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
