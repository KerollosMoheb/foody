import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/shared/custom_text.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({
    super.key,
    required this.userName,
    required this.userImage,
  });
  final String userName;
  final String userImage;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                  text: 'Hello,',
                  fontSize: 30,
                  fontWeight: FontWeight.w200,
                  color: Colors.grey.shade500,
                ),
                CustomText(
                  text: userName,
                  fontSize: 30,
                  fontWeight: FontWeight.w200,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
            // SvgPicture.asset(
            //     'assets/logo/logo.svg',
            //     color: AppColors.primary,
            //     height: 28,
            // ),
            CustomText(
              text: 'Hungry Today?',
              fontSize: 14,
              fontWeight: FontWeight.w200,
              color: Colors.grey.shade500,
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.primaryColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              userImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.person, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
