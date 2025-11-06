import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/core/network/api_error.dart';
import 'package:food_app/features/auth/data/auth_repo.dart';
import 'package:food_app/features/auth/data/user_model.dart';
import 'package:food_app/features/home/data/models/product_model.dart';
import 'package:food_app/features/home/data/repo/product_repo.dart';
import 'package:food_app/features/home/widgets/card_item.dart';
import 'package:food_app/features/home/widgets/food_category.dart';
import 'package:food_app/features/home/widgets/search_field.dart';
import 'package:food_app/features/home/widgets/user_header.dart';
import 'package:food_app/features/product/views/product_details_view.dart';
import 'package:food_app/shared/custom_snack.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List category = ['All', 'Combos', 'Sliders', 'Classic', 'Drinks'];
  int selectedIndex = 0;
  final TextEditingController controller = TextEditingController();

  List<ProductModel>? allProducts;
  List<ProductModel>? products;
  ProductRepo productRepo = ProductRepo();

  UserModel? userModel;
  AuthRepo authRepo = AuthRepo();
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

  Future<void> getProducts() async {
    final response = await productRepo.getProducts();
    setState(() {
      allProducts = response;
      products = response;
    });
  }

  @override
  void initState() {
    getProfileData();
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Skeletonizer(
        enabled: products == null,
        child: Scaffold(
          body: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              /// header
              SliverAppBar(
                elevation: 0,
                pinned: true,
                floating: false,
                toolbarHeight: 190,
                scrolledUnderElevation: 0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                flexibleSpace: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 500),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(450).withOpacity(0.1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 70,
                          right: 20,
                          left: 20,
                        ),
                        child: Column(
                          children: [
                            UserHeader(
                              userName: userModel?.name ?? "User",
                              userImage:
                                  userModel?.image.toString() ??
                                  "https://www.pngall.com/wp-content/uploads/5/Profile-PNG-High-Quality-Image.png",
                            ),
                            Gap(20),
                            SearchField(
                              controller: controller,
                              onChanged: (value) {
                                setState(() {
                                  products = allProducts
                                      ?.where(
                                        (product) => product.name
                                            .toLowerCase()
                                            .contains(value.toLowerCase()),
                                      )
                                      .toList();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              /// Category
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: FoodCategory(
                    selectedIndex: selectedIndex,
                    category: category,
                  ),
                ),
              ),

              /// GridView
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .63,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: products?.length ?? 6,
                    (context, index) {
                      final product = products?[index];
                      if (product == null) {
                        return CupertinoActivityIndicator();
                      }
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) {
                              return ProductDetailsView(
                                productImage: product.image,
                                productId: product.id,
                                productPrice: product.price,
                              );
                            },
                          ),
                        ),
                        child: CardItem(
                          title: product.name,
                          image: product.image,
                          description: product.desc,
                          rating: product.rating,
                        ),
                      );
                    },
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
