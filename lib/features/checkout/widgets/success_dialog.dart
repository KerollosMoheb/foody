import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/shared/custom_button.dart';
import 'package:food_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 200),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade800,
                blurRadius: 15,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                radius: 40,
                child: Icon(
                  CupertinoIcons.check_mark,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              Gap(20),
              CustomText(
                text: 'Success !',
                color: AppColors.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              Gap(20),
              CustomText(
                text:
                    'Your payment was successful.A receipt for this purchase has been sent to your email.',
                color: Color(0xffBCBBBB),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              Gap(50),
              CustomButton(
                text: 'Go Back',
                width: 220,
                height: 60,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
