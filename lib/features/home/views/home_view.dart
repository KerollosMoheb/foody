import 'package:flutter/material.dart';
import 'package:food_app/features/home/widgets/card_item.dart';
import 'package:food_app/features/home/widgets/food_category.dart';
import 'package:food_app/features/home/widgets/seatch_field.dart';
import 'package:food_app/features/home/widgets/user_header.dart';
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
          slivers: [
            //Header
            SliverAppBar(
              elevation: 0,
              pinned: true,
              floating: false,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
              toolbarHeight: 170,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: EdgeInsets.only(top: 38, right: 20, left: 20),
                child: Column(
                  children: [UserHeader(), Gap(20), SeatchField(), Gap(5)],
                ),
              ),
            ),
            //Categories
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: FoodCategory(
                  selectedIndex: selectedIndex,
                  category: category,
                ),
              ),
            ),
            //card Items
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.67,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return CardItem(
                    image: 'assets/test/test.png',
                    title: 'Cheeseburger',
                    description: 'Wendy\'s Burger',
                    rating: '4.9',
                  );
                }, childCount: 6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
