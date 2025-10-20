import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/core/network/api_error.dart';
import 'package:food_app/features/auth/data/auth_repo.dart';
import 'package:food_app/features/auth/views/login_view.dart';
import 'package:food_app/features/auth/widgets/custom_auth_button.dart';
import 'package:food_app/root.dart';
import 'package:food_app/shared/custom_snack.dart';
import 'package:food_app/shared/custom_text.dart';
import 'package:food_app/shared/custom_text_form_field.dart';
import 'package:food_app/shared/glass_container.dart';
import 'package:gap/gap.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthRepo authRepo = AuthRepo();

  Future<void> signUp() async {
    setState(() => isLoading = true);
    try {
      final user = await authRepo.signup(
        nameController.text.trim(),
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
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(toolbarHeight: 0.0, backgroundColor: Colors.white),
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
                  Center(
                    child: CustomText(
                      text: 'Welcome to our Food App',
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Gap(40),
                  glassContainer(
                    child: Column(
                      children: [
                        Gap(30),
                        CustomTxtfield(
                          controller: nameController,
                          hint: 'Name',
                          isPassword: false,
                        ),
                        Gap(10),
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

                        /// Sign up
                        isLoading
                            ? CupertinoActivityIndicator()
                            : CustomAuthButton(
                                color: AppColors.primaryColor,
                                textColor: Colors.white,
                                text: 'Sign up',
                                onTap: signUp,
                              ),

                        Gap(10),
                        Row(
                          children: [
                            ///  Login
                            Expanded(
                              child: CustomAuthButton(
                                textColor: AppColors.primaryColor,
                                color: Colors.white,
                                text: 'Login',
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (c) {
                                        return LoginView();
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
