import 'package:ecom_app/ecom/presentation/provider/nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:ecom_app/ecom/core/constants/theme/app_colors.dart';
import 'package:ecom_app/ecom/presentation/pages/cart.dart';
import 'package:ecom_app/ecom/presentation/pages/wishlist.dart';
import 'package:ecom_app/ecom/presentation/pages/homepage.dart';

class HomePageMain extends StatelessWidget {
  final int? index;
  const HomePageMain({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = context.watch<NavProvider>().currentIndex;

    const List<Widget> tabs = [
      HomePage(),
      CartScreen(),
      WishlistScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: tabs[selectedIndex]),
      bottomNavigationBar: Container(
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: GNav(
            onTabChange: (index) {
              context.read<NavProvider>().setIndex(index);
            },
            backgroundColor: AppColors.white,
            color: AppColors.grey,
            activeColor: AppColors.black,
            tabBackgroundColor: AppColors.grey300,
            gap: 6,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
            iconSize: 26,
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.shopping_cart, text: 'Cart'),
              GButton(icon: Icons.favorite, text: 'Wishlist'),
            ],
          ),
        ),
      ),
    );
  }
}
