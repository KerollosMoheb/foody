import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/core/network/api_error.dart';
import 'package:food_app/features/auth/data/auth_repo.dart';
import 'package:food_app/features/auth/views/signup_view.dart';
import 'package:food_app/features/auth/widgets/custom_auth_button.dart';
import 'package:food_app/root.dart';
import 'package:food_app/shared/custom_snack.dart';
import 'package:food_app/shared/custom_text.dart';
import 'package:food_app/shared/custom_text_form_field.dart';
import 'package:gap/gap.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    AuthRepo authRepo = AuthRepo();

    Future<void> login() async {
      setState(() => isLoading = true);
      try {
        final user = await authRepo.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Root()),
          );
        }
      } catch (e) {
        String errorMsg = "Something Went Wrong";
        if (e is ApiError) {
          errorMsg = e.message;
        }
        ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
      } finally {
        setState(() => isLoading = false);
      }
    }

    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gap(200),
                  SvgPicture.asset(
                    'assets/logo/logo.svg',
                    color: AppColors.primaryColor,
                  ),
                  Gap(10),
                  CustomText(
                    text: 'Welcome Back, Discover The Fast Food',
                    color: AppColors.primaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  Gap(60),
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
                            isLoading
                                ? CupertinoActivityIndicator(
                                    color: Colors.white,
                                  )
                                : CustomAuthButton(
                                    color: AppColors.primaryColor,
                                    textColor: Colors.white,
                                    text: 'Login',
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        login();
                                      }
                                    },
                                  ),
                            Gap(15),

                            /// go to Signup
                            CustomAuthButton(
                              textColor: AppColors.primaryColor,
                              color: Colors.white,
                              text: 'Create Account ?',
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (c) {
                                      return SignupView();
                                    },
                                  ),
                                );
                              },
                            ),

                            /// Guest
                            Gap(20),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (c) {
                                      return Root();
                                    },
                                  ),
                                );
                              },
                              child: CustomText(
                                text: 'Continue as a guest ?',
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
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
        ),
      ),
    );
  }
}
