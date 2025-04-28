import 'package:ecom_app/ecom/core/constants/assets/app_icons.dart';
import 'package:ecom_app/ecom/core/constants/strings/app_strings.dart';
import 'package:ecom_app/ecom/core/constants/theme/app_colors.dart';
import 'package:ecom_app/ecom/core/constants/assets/app_lotties.dart';
import 'package:ecom_app/ecom/core/messages/message.dart';
import 'package:ecom_app/ecom/presentation/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.grey100,
      appBar: AppBar(
        title: const Text(AppStrings.cartAppBarTitle),
        backgroundColor: AppColors.grey100,
        leading: Image.asset(
          AppIcons.goback,
          scale: 15,
        ),
      ),
      body: cartProvider.cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    AppLotties.emptyCart,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    AppStrings.emptyCartTitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartProvider.cartItems[index];
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
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item.product.image,
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
                                          item.product.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              wordSpacing: 1),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          item.product.description,
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
                                              "\₹${item.product.price}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: .5),
                                            ),
                                            Container(
                                              height: 32,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.28,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColors.golden),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () => cartProvider
                                                        .decreaseQuantity(
                                                            item.product),
                                                    child: const Icon(
                                                        Icons.remove,
                                                        size: 18),
                                                  ),
                                                  Text(
                                                    item.quantity.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () => cartProvider
                                                        .increaseQuantity(
                                                            item.product),
                                                    child: const Icon(Icons.add,
                                                        size: 18),
                                                  ),
                                                ],
                                              ),
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
                                      cartProvider.removeFromCart(item.product);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        CustomSnackBar.get(
                                          message:
                                              AppStrings.removeFromCartMessage,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        border: Border(
                                          top: BorderSide(
                                              color: AppColors.grey200,
                                              width: 1),
                                          right: BorderSide(
                                              color: AppColors.grey200,
                                              width: 1),
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
                                    onTap: () {},
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        border: Border(
                                          top: BorderSide(
                                              color: AppColors.grey200,
                                              width: 1),
                                          right: BorderSide(
                                              color: AppColors.grey200,
                                              width: .5),
                                          left: BorderSide(
                                              color: AppColors.grey200,
                                              width: 1),
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
                                              AppStrings.buyThisNowBtn,
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
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          '${cartProvider.formattedTotalPrice}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        width: 140,
                        decoration: BoxDecoration(
                          color: AppColors.amber,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Shimmer.fromColors(
                          period: const Duration(seconds: 4),
                          baseColor: AppColors.black,
                          highlightColor: AppColors.white,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              AppStrings.placeOrder,
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
