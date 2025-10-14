import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/features/auth/views/login_view.dart';
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

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Gap(200),
              SvgPicture.asset(
                'assets/logo/logo.svg',
                color: AppColors.primaryColor,
              ),
              CustomText(
                text: 'Welcome to our Food App',
                color: AppColors.primaryColor,
              ),
              Gap(100),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Gap(30),
                        CustomTxtfield(
                          controller: nameController,
                          hint: 'Name',
                          isPassword: false,
                        ),
                        Gap(15),
                        CustomTxtfield(
                          controller: emailController,
                          hint: 'Email Address',
                          isPassword: false,
                        ),
                        Gap(15),
                        CustomTxtfield(
                          controller: passwordController,
                          hint: 'Password',
                          isPassword: true,
                        ),
                        Gap(20),

                        /// Sign up
                        CustomAuthButton(
                          color: AppColors.primaryColor,
                          textColor: Colors.white,
                          text: 'Sign up',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              print('success register');
                            }
                          },
                        ),
                        Gap(15),

                        /// go to login
                        CustomAuthButton(
                          textColor: AppColors.primaryColor,
                          color: Colors.white,
                          text: 'Go To Login ?',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) {
                                  return LoginView();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
