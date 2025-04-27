import 'package:ecom_app/ecom/core/constants/strings/app_strings.dart';
import 'package:ecom_app/ecom/core/constants/theme/app_colors.dart';
import 'package:ecom_app/ecom/core/messages/message.dart';
import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
import 'package:ecom_app/ecom/presentation/provider/cart_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/product_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/wishlist_provider.dart';
import 'package:ecom_app/ecom/presentation/widgets/product_details.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ItemsDisplay extends StatefulWidget {
  const ItemsDisplay({super.key});

  @override
  State<ItemsDisplay> createState() => _ItemsDisplayState();
}

class _ItemsDisplayState extends State<ItemsDisplay> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProductProvider>(context, listen: false);
      provider.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    final productsToShow = provider.products.isNotEmpty
        ? provider.products
        : [];

    return provider.isLoading
        ?  Center(
            child:  LoadingAnimationWidget.discreteCircle(
                                        color: AppColors.primary,
                                        secondRingColor: Colors.grey,
                                        thirdRingColor: AppColors.black,
                                        size: 30,
                                       ))
        : provider.errorMessage.isNotEmpty
            ? Center(child: Text(provider.errorMessage))
            : GridView.builder(
                shrinkWrap: true,
                itemCount: productsToShow.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 295,
                ),
                itemBuilder: (context, index) {
                  ProductEntity product = productsToShow[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: product)),
                      );
                    },
                    child: Container(
                      height: 295,
                      decoration: BoxDecoration(
                        color: AppColors.grey100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(125),
                                  child: Image.network(
                                    product.image,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  product.title,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        product.description,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            const TextStyle(color: Colors.black38),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow[700],
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      product.ratings.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: Colors.black38),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  '\$${product.price}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: -2,
                            right: -2,
                            child: IconButton(
                              onPressed: () {
                                wishlistProvider.addToWishlist(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackBar.get(
                                    message: AppStrings.addItemToWishListMsg,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.favorite_border,
                                color: AppColors.grey500,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () {
                                // Add to cart
                                cartProvider.addToCart(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackBar.get(
                                    message: AppStrings.addItemToCart,
                                  ),
                                );
                              },
                              child: Material(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10),
                                elevation: 4,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
  }
}
