import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/core/constants/app_colors.dart';
import 'package:food_app/features/cart/data/cart_model.dart';
import 'package:food_app/features/cart/data/cart_repo.dart';
import 'package:food_app/features/home/data/models/topping_model.dart';
import 'package:food_app/features/home/data/repo/product_repo.dart';
import 'package:food_app/features/product/widgets/spicy_slider.dart';
import 'package:food_app/features/product/widgets/topping_card.dart';
import 'package:food_app/shared/custom_button.dart';
import 'package:food_app/shared/custom_text.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.productImage,
    required this.productId,
    required this.productPrice,
  });
  final String productImage;
  final int productId;
  final String productPrice;
  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value = 0.5;
  List<int> selectedToppings = [];
  List<int> selectedOptions = [];

  List<ToppingModel>? toppings;
  List<ToppingModel>? options;

  bool isLoading = false;

  ProductRepo productRepo = ProductRepo();
  CartRepo cartRepo = CartRepo();

  Future<void> getToppings() async {
    final response = await productRepo.getToppings();
    setState(() {
      toppings = response;
    });
  }

  Future<void> getOptions() async {
    final response = await productRepo.getOptions();
    setState(() {
      options = response;
    });
  }

  @override
  void initState() {
    getToppings();
    getOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: widget.productImage.isEmpty,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
          toolbarHeight: 18,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_circle_left_outlined,
              size: 20,
              color: AppColors.primaryColor,
            ),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpicySlider(
                  value: value,
                  img: widget.productImage,
                  onChanged: (v) => setState(() => value = v),
                ),

                Gap(40),
                CustomText(text: 'Toppings', fontSize: 18),
                Gap(10),
                SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(toppings?.length ?? 4, (index) {
                      final topping = toppings?[index];
                      final id = topping?.id;
                      if (topping == null) {
                        return CupertinoActivityIndicator();
                      }
                      final isSelected = selectedToppings.contains(id);
                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: ToppingCard(
                          color: isSelected
                              ? Colors.yellow.withOpacity(0.2)
                              : AppColors.primaryColor.withOpacity(0.1),
                          title: topping.name,
                          imageUrl: topping.image,
                          onAdd: () async {
                            setState(() {
                              if (isSelected) {
                                selectedToppings.remove(id);
                              } else {
                                selectedToppings.add(id!);
                              }
                            });
                          },
                        ),
                      );
                    }),
                  ),
                ),

                Gap(25),
                CustomText(text: 'Side Options', fontSize: 18),
                Gap(10),
                SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(options?.length ?? 4, (index) {
                      final option = options?[index];
                      final id = option?.id;
                      if (option == null) {
                        return CupertinoActivityIndicator();
                      }
                      final isSelected = selectedOptions.contains(id);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ToppingCard(
                          color: isSelected
                              ? Colors.yellow.withOpacity(0.2)
                              : AppColors.primaryColor.withOpacity(0.1),
                          imageUrl: option.image,
                          title: option.name,
                          onAdd: () {
                            setState(() {
                              if (isSelected) {
                                selectedOptions.remove(id);
                              } else {
                                selectedOptions.add(id!);
                              }
                            });
                          },
                        ),
                      );
                    }),
                  ),
                ),
                Gap(200),
              ],
            ),
          ),
        ),

        bottomSheet: Container(
          height: 110,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor.withOpacity(0.7),
                AppColors.primaryColor,
                AppColors.primaryColor,
                AppColors.primaryColor,
                AppColors.primaryColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Burger Price :',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    CustomText(
                      text: '\$ ${widget.productPrice}',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                CustomButton(
                  widget: isLoading
                      ? CupertinoActivityIndicator(
                          color: AppColors.primaryColor,
                        )
                      : Icon(CupertinoIcons.cart_badge_plus),
                  gap: 10,
                  height: 48,
                  color: Colors.white,
                  textColor: AppColors.primaryColor,
                  text: 'Add To Cart',
                  onTap: () async {
                    try {
                      setState(() => isLoading = true);
                      final cartItem = CartModel(
                        productId: widget.productId,
                        qty: 1,
                        spicy: value,
                        toppings: selectedToppings,
                        options: selectedOptions,
                      );
                      await cartRepo.addToCart(
                        CartRequestModel(items: [cartItem]),
                      );
                      setState(() => isLoading = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("✅ Add to Cart successfully")),
                      );
                    } catch (e) {
                      setState(() => isLoading = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "❌ Failed to add to cart: ${e.toString()}",
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
