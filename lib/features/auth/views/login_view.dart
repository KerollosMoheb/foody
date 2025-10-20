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
import 'package:food_app/shared/glass_container.dart';
import 'package:gap/gap.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;

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

  @override
  void initState() {
    emailController.text = 'koko@gmail.com';
    passwordController.text = '123456789';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(toolbarHeight: 0.0, backgroundColor: Colors.white),
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(100),
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
                  glassContainer(
                    child: Column(
                      children: [
                        Gap(30),
                        CustomTxtfield(
                          controller: emailController,
                          hint: 'Email Address',
                          isPassword: false,
                        ),
                        Gap(10),
                        CustomTxtfield(
                          controller: passwordController,
                          hint: 'Password',
                          isPassword: true,
                        ),
                        Gap(20),

                        /// Login Button
                        isLoading
                            ? CupertinoActivityIndicator(
                                color: AppColors.primaryColor,
                              )
                            : CustomAuthButton(
                                text: 'Login',
                                onTap: login,
                                color: AppColors.primaryColor,
                                textColor: Colors.white,
                              ),

                        Gap(10),
                        Row(
                          children: [
                            ///  Signup
                            Expanded(
                              child: CustomAuthButton(
                                color: Colors.white,
                                textColor: AppColors.primaryColor,
                                text: 'Signup',
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
                            ),
                            Gap(15),

                            /// Guest
                            Expanded(
                              child: CustomAuthButton(
                                color: Colors.white,
                                textColor: AppColors.primaryColor,
                                text: 'Guest',
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
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                      ],
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
