import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/core/network/api_error.dart';
import 'package:food_app/features/auth/data/auth_repo.dart';
import 'package:food_app/features/auth/data/user_model.dart';
import 'package:food_app/features/auth/views/login_view.dart';
import 'package:food_app/features/auth/widgets/custom_user_text_field.dart';
import 'package:food_app/shared/custom_button.dart';
import 'package:food_app/shared/custom_snack.dart';
import 'package:food_app/shared/custom_text.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _visa = TextEditingController();

  bool isGuest = false;

  UserModel? userModel;
  String? selectedImage;
  bool isLoadingUpdate = false;
  bool isLoadingLogout = false;
  AuthRepo authRepo = AuthRepo();

  Future<void> autoLogin() async {
    final user = await authRepo.autoLogin();
    setState(() => isGuest = authRepo.isGuest);
    if (user != null) setState(() => userModel = user);
  }

  /// get profile
  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errorMsg = 'Error in Profile';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
    }
  }

  /// update profile
  Future<void> updateProfileData() async {
    try {
      setState(() => isLoadingUpdate = true);
      final user = await authRepo.updateProfileData(
        name: _name.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
        imagePath: selectedImage,
        visa: _visa.text.trim(),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnack('Profile updated Successfully'));
      setState(() => isLoadingUpdate = false);
      setState(() => userModel = user);
      await getProfileData();
    } catch (e) {
      setState(() => isLoadingUpdate = false);
      String errorMsg = 'Failed to update profile';
      if (e is ApiError) errorMsg = e.message;
      print(errorMsg);
    }
  }

  /// logout
  Future<void> logout() async {
    try {
      setState(() => isLoadingLogout = true);
      await authRepo.logout();
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => LoginView()),
      );
      setState(() => isLoadingLogout = false);
    } catch (e) {
      setState(() => isLoadingLogout = false);
      print(e.toString());
    }
  }

  /// pick image
  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage.path;
      });
    }
  }

  @override
  void initState() {
    autoLogin();
    getProfileData().then((v) {
      _name.text = userModel?.name.toString() ?? 'Knuckles';
      _email.text = userModel?.email.toString() ?? 'Knuckles@gmail.com';
      _address.text = userModel?.address == null
          ? "55 Dubai, UAE"
          : userModel!.address!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isGuest) {
      return RefreshIndicator(
        displacement: 60,
        color: Colors.white,
        backgroundColor: AppColors.primaryColor,
        onRefresh: () async => await getProfileData(),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0.0,
              backgroundColor: Colors.white,
              scrolledUnderElevation: 0.0,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                child: Skeletonizer(
                  enabled: userModel == null,
                  child: Column(
                    children: [
                      Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 0,
                            ),
                            child: Icon(CupertinoIcons.settings_solid),
                          ),
                        ],
                      ),

                      /// image
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.black),
                          color: Colors.grey.shade300,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(3),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.primaryColor,
                                ),
                                color: Colors.grey.shade100,
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: selectedImage != null
                                  ? Image.file(
                                      File(selectedImage!),
                                      fit: BoxFit.cover,
                                    )
                                  : (userModel?.image != null &&
                                        userModel!.image!.isNotEmpty)
                                  ? Image.network(
                                      userModel!.image!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, err, builder) =>
                                          Icon(Icons.person),
                                    )
                                  : Icon(Icons.person),
                            ),
                          ),
                        ),
                      ),

                      Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: pickImage,
                            child: Card(
                              elevation: 1,
                              shadowColor: Colors.grey,
                              color: Colors.blue.shade800,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                      text: 'upload image',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                    Gap(10),
                                    Icon(
                                      CupertinoIcons.camera,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: pickImage,
                            child: Card(
                              elevation: 1,
                              shadowColor: Colors.grey,
                              color: Colors.red.shade900,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(
                                      text: 'remove image',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                    Gap(10),
                                    Icon(
                                      CupertinoIcons.trash,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(30),

                      /// Form
                      CustomUserTextField(controller: _name, labelText: 'Name'),
                      Gap(25),
                      CustomUserTextField(
                        controller: _email,
                        labelText: 'Email',
                      ),
                      Gap(25),
                      CustomUserTextField(
                        controller: _address,
                        labelText: 'Address',
                      ),
                      Gap(20),
                      Divider(),
                      Gap(10),
                      userModel?.visa == null
                          ? CustomUserTextField(
                              controller: _visa,
                              textInputType: TextInputType.number,
                              labelText: 'ADD VISA CARD',
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.grey.shade900,
                                    Colors.grey.shade800,
                                    Colors.grey.shade900,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/icon/profileVisa.png',
                                    width: 45,
                                    color: Colors.white,
                                  ),
                                  Gap(20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: 'Debit card',
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                      CustomText(
                                        text:
                                            userModel?.visa ??
                                            "**** **** **** 9857",
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: CustomText(
                                      text: 'Default',
                                      color: Colors.grey.shade800,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Gap(10),
                                  Icon(
                                    CupertinoIcons.check_mark_circled_solid,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                      Gap(10),
                      SizedBox(
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Edit
                            Expanded(
                              child: GestureDetector(
                                onTap: updateProfileData,
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: isLoadingUpdate
                                      ? CupertinoActivityIndicator(
                                          color: Colors.white,
                                        )
                                      : Center(
                                          child: CustomText(
                                            text: 'Edit Profile',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                ),
                              ),
                            ),

                            Gap(10),

                            /// logout
                            Expanded(
                              child: GestureDetector(
                                onTap: logout,
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: isLoadingLogout
                                      ? CupertinoActivityIndicator(
                                          color: AppColors.primaryColor,
                                        )
                                      : Center(
                                          child: CustomText(
                                            text: 'Logout',
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(300),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else if (isGuest) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Guest Mode')),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CustomButton(text: 'LOGOUT', onTap: logout),
          ),
        ],
      );
    }
    return SizedBox();
  }
}
