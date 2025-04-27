import 'package:ecom_app/ecom/core/constants/assets/app_icons.dart';
import 'package:ecom_app/ecom/core/constants/strings/app_strings.dart';
import 'package:ecom_app/ecom/core/constants/theme/app_colors.dart';
import 'package:ecom_app/ecom/core/constants/assets/app_lotties.dart';
import 'package:ecom_app/ecom/core/messages/message.dart';
import 'package:ecom_app/ecom/presentation/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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
        leading: Image.asset(AppIcons.goback,scale: 15,),
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
                            vertical: 8, horizontal: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item.product.image,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item.product.description,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.grey700,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "\$${item.product.price}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // Quantity Control
                              Container(
                                height: 36,
                                width: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.5, color: AppColors.golden),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () => cartProvider
                                          .decreaseQuantity(item.product),
                                      child: const Icon(Icons.remove, size: 20),
                                    ),
                                    Text(
                                      item.quantity.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => cartProvider
                                          .increaseQuantity(item.product),
                                      child: const Icon(Icons.add, size: 20),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        cartProvider
                                            .removeFromCart(item.product);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          CustomSnackBar.get(
                                            message: AppStrings.removeFromCartMessage,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: AppColors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                                    color: AppColors.grey500,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: AppColors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                                AppStrings.buyNowBtn,
                                                style: TextStyle(
                                                    color: AppColors.grey500,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                        ),
                      );
                    },
                  ),
                ),

                // Bottom total price and checkout section
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white, // White background
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withOpacity(0.05), // Soft light shadow
                        blurRadius: 10,
                        offset: const Offset(0, -2), // Only at the top
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Total Price
                      Text(
                        'Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Checkout Button
                      ElevatedButton(
                        onPressed: () {
                          // Implement Checkout functionality
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.black, // Black button
                          foregroundColor: Colors.white, // White text
                          elevation: 0,
                        ),
                        child: const Text(
                          AppStrings.checkOut,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
