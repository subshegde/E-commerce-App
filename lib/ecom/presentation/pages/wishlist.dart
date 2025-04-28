import 'package:ecom_app/ecom/core/constants/assets/app_icons.dart';
import 'package:ecom_app/ecom/core/constants/assets/app_lotties.dart';
import 'package:ecom_app/ecom/core/constants/strings/app_strings.dart';
import 'package:ecom_app/ecom/core/constants/theme/app_colors.dart';
import 'package:ecom_app/ecom/core/messages/message.dart';
import 'package:ecom_app/ecom/presentation/provider/cart_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.grey100,
      appBar: AppBar(
        title: const Text(AppStrings.wishListAppBarTitle),
        backgroundColor: AppColors.grey100,
        elevation: 0,
        centerTitle: false,
        leading: Image.asset(
          AppIcons.goback,
          scale: 15,
        ),
      ),
      body: Consumer<WishlistProvider>(
        builder: (context, wishlistProvider, child) {
          return wishlistProvider.wishlistItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        AppLotties.emptyWishlist,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        AppStrings.emptyWishList,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: wishlistProvider.wishlistItems.length,
                  itemBuilder: (context, index) {
                    final item = wishlistProvider.wishlistItems[index];
                    return Card(
                      color: AppColors.white,
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    item.image,
                                    width: 80,
                                    height: 130,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            wordSpacing: 1),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        item.description,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.grey700,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\₹${item.price}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: .5),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    wishlistProvider.removeFromWishlist(item);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      CustomSnackBar.get(
                                        message:
                                            AppStrings.removeItemFromWishList,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      border: Border(
                                        top: BorderSide(
                                            color: AppColors.grey200, width: 1),
                                        right: BorderSide(
                                            color: AppColors.grey200, width: 1),
                                        left: BorderSide(
                                            color: AppColors.grey200,
                                            width: .5),
                                      ),
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color: AppColors.grey500,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            AppStrings.removeBtn,
                                            style: TextStyle(
                                                color: AppColors.grey600,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 1),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    cartProvider.addToCart(item);
                                    wishlistProvider.removeFromWishlist(item);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      CustomSnackBar.get(
                                        message: AppStrings.movedToCartMes,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      border: Border(
                                        top: BorderSide(
                                            color: AppColors.grey200, width: 1),
                                        right: BorderSide(
                                            color: AppColors.grey200,
                                            width: .5),
                                        left: BorderSide(
                                            color: AppColors.grey200, width: 1),
                                      ),
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.shopping_cart_checkout,
                                            color: AppColors.grey500,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            AppStrings.moveToCart,
                                            style: TextStyle(
                                                color: AppColors.grey600,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}