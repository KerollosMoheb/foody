import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

SnackBar customSnack(errorMsg) {
  return SnackBar(
    backgroundColor: Colors.red.shade900,
    duration: Duration(milliseconds: 3000),
    content: Row(
      children: [
        Icon(CupertinoIcons.info, color: Colors.white),
        Gap(20),
        CustomText(text: errorMsg, fontSize: 14, fontWeight: FontWeight.w600),
      ],
    ),
  );
}
