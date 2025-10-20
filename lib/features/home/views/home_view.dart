import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_app/features/home/widgets/card_item.dart';
import 'package:food_app/features/home/widgets/food_category.dart';
import 'package:food_app/features/home/widgets/search_field.dart';
import 'package:food_app/features/home/widgets/user_header.dart';
import 'package:food_app/features/product/views/product_details_view.dart';
import 'package:gap/gap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    List category = ['All', 'Combos', 'Sliders', 'Classic', 'Drinks'];
    int selectedIndex = 0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
                      // gradient:  LinearGradient(
                      //     colors: [
                      //   AppColors.primary,
                      //   AppColors.primary,
                      //   AppColors.primary.withOpacity(0.9),
                      //   AppColors.primary.withOpacity(0.9),
                      //   AppColors.primary.withOpacity(0.9),
                      //   AppColors.primary,
                      // ],
                      //     begin: Alignment.topCenter,
                      //     end: Alignment.bottomCenter
                      // ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 70,
                        right: 20,
                        left: 20,
                      ),
                      child: Column(
                        children: [UserHeader(), Gap(20), SearchField()],
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
                  childAspectRatio: 0.83,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: 6,
                  (context, index) => GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) {
                          return ProductDetailsView();
                        },
                      ),
                    ),
                    child: CardItem(
                      image: 'assets/test/test.png',
                      title: 'Cheeseburger',
                      description: 'Wendy"s Burger',
                      rating: '4.9',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
