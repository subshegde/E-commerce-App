import 'package:ecom_app/ecom/core/constants/assets/app_icons.dart';
import 'package:ecom_app/ecom/core/constants/strings/app_strings.dart';
import 'package:ecom_app/ecom/core/constants/theme/app_colors.dart';
import 'package:ecom_app/ecom/core/messages/message.dart';
import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
import 'package:ecom_app/ecom/presentation/provider/cart_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Container(
          height: 45,
          margin: const EdgeInsets.symmetric(horizontal: 0),
          padding: const EdgeInsets.only(right: 0),
          decoration: BoxDecoration(
              color: AppColors.grey300,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.grey700,
                    ),
                    hintText: "Search..",
                    hintStyle: const TextStyle(color: Colors.black26)),
              )),
            ],
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  AppIcons.goCart,
                  scale: 20,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Hero(
                  tag: product.id,
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(product.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.grey300,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon:
                          Icon(Icons.favorite_border, color: AppColors.grey800),
                      onPressed: () {
                        wishlistProvider.addToWishlist(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackBar.get(
                            message: AppStrings.addItemToWishListMsg,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 65,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.grey300,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.share, color: AppColors.grey800),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                product.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow[700],
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    product.ratings.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black38),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '${product.productNumRatings.toString()} ratings',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Transform.rotate(
            //     angle: 23 * 3.14159 / 180,
            //     child: Shimmer.fromColors(
            //       baseColor: Colors.grey.shade300,
            //       highlightColor: Colors.red,
            //       child: Image.asset(
            //         AppImages.hotdeal,
            //         scale: 3,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_downward,
                    color: Colors.green,
                    size: 20,
                  ),
                  const Text(
                    "20%",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      const Text(
                        "\$",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        product.price.toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                product.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                cartProvider.addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar.get(
                    message: AppStrings.addItemToCart,
                  ),
                );
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Image.asset(
                  AppIcons.addToCart,
                  scale: 20,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  padding: const EdgeInsets.symmetric(vertical: 12.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: const Text(
                  AppStrings.empBtn,
                  style: TextStyle(color: Colors.grey, fontSize: 17),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 140,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Shimmer.fromColors(
                period: const Duration(seconds: 4),
                baseColor: AppColors.black,
                highlightColor: Colors.white,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    AppStrings.buyNowBtn,
                    style: TextStyle(fontSize: 20),
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
