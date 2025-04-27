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
                          vertical: 10, horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        subtitle: Text(
                          "\$${item.price}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey600,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.shopping_cart_outlined),
                              onPressed: () {
                                cartProvider.addToCart(item);
                                wishlistProvider.removeFromWishlist(item);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackBar.get(
                                    message: AppStrings.movedToCartMes,
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () {
                                wishlistProvider.removeFromWishlist(item);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackBar.get(
                                    message: AppStrings.removeItemFromWishList,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
