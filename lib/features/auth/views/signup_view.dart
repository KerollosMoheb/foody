import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/features/auth/widgets/custom_auth_button.dart';
import 'package:food_app/shared/custom_text.dart';
import 'package:food_app/shared/custom_text_form_field.dart';
import 'package:gap/gap.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gap(100),
                  SvgPicture.asset('assets/logo/logo.svg'),
                  Gap(10),
                  CustomText(
                    text: 'Welcome to Foody',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  Gap(60),
                  CustomTextFormField(
                    hintText: 'Name',
                    isPassword: false,
                    controller: nameController,
                  ),
                  Gap(20),
                  CustomTextFormField(
                    hintText: 'Email Address',
                    isPassword: false,
                    controller: emailController,
                  ),
                  Gap(20),
                  CustomTextFormField(
                    hintText: 'Password',
                    isPassword: true,
                    controller: passwordController,
                  ),
                  Gap(20),
                  CustomTextFormField(
                    hintText: 'Confirm Password',
                    isPassword: true,
                    controller: confirmPasswordController,
                  ),
                  Gap(30),
                  CustomAuthButton(
                    text: 'Signup',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        print('Signup');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
