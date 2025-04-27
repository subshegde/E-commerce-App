import 'package:ecom_app/ecom/core/constants/assets/app_icons.dart';
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

    final productsToShow =
        provider.products.isNotEmpty ? provider.products : [];

    return provider.isLoading
        ? Center(
            child: LoadingAnimationWidget.discreteCircle(
            color: AppColors.primary,
            secondRingColor: Colors.grey,
            thirdRingColor: AppColors.black,
            size: 30,
          ))
        : productsToShow.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20,),
                  Image.asset(
                    AppIcons.noDataFound,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      AppStrings.notDataFound,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              )
            : provider.errorMessage.isNotEmpty
                ? const Center(child: Text(AppStrings.error))
                : GridView.builder(
                    shrinkWrap: true,
                    itemCount: productsToShow.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                builder: (context) => ProductDetailScreen(
                                      id: product.id,
                                    )),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      product.title,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            product.description,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: AppColors.grey700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: AppColors.yellow700,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            product.ratings.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: AppColors.grey700),
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
                                        color: AppColors.black,
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
                                    if (product != null &&
                                        !wishlistProvider.wishlistItems.any(
                                            (item) => item.id == product.id)) {
                                      wishlistProvider.addToWishlist(product);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        CustomSnackBar.get(
                                          message:
                                              AppStrings.addItemToWishListMsg,
                                        ),
                                      );
                                    } else if (product != null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        CustomSnackBar.get(
                                          message:
                                              AppStrings.alreadyinWishlistMsg,
                                        ),
                                      );
                                    }
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
                                    if (product != null &&
                                        !cartProvider.cartItems.any((item) =>
                                            item.product.id == product.id)) {
                                      cartProvider.addToCart(product);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        CustomSnackBar.get(
                                          message: AppStrings.addItemToCart,
                                        ),
                                      );
                                    } else if (product != null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        CustomSnackBar.get(
                                          message: AppStrings.alreadyinCartMsg,
                                        ),
                                      );
                                    }
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
                                            color: AppColors.black
                                                .withOpacity(0.2),
                                            blurRadius: 8,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.shopping_cart,
                                        color: AppColors.white,
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
