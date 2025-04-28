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
                  const SizedBox(
                    height: 20,
                  ),
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
                    padding: const EdgeInsets.all(1),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: .5,
                      crossAxisSpacing: .5,
                      mainAxisExtent: 235,
                    ),
                    itemBuilder: (context, index) {
                      ProductEntity product = productsToShow[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(id: product.id),
                            ),
                          );
                        },
                        child: Container(
                          height: 205,
                          padding: const EdgeInsets.all(5),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: .2, color: AppColors.grey400),
                            color: AppColors.grey100,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    child: ClipRRect(
                                      child: Image.network(
                                        product.image,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Positioned(
                                  top: -9.2,
                                  right: -8,
                                  child: IconButton(
                                    onPressed: () {
                                      if (product != null &&
                                          !wishlistProvider.wishlistItems.any(
                                              (item) =>
                                                  item.id == product.id)) {
                                        wishlistProvider.addToWishlist(product);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          CustomSnackBar.get(
                                              message: AppStrings
                                                  .addItemToWishListMsg),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          CustomSnackBar.get(
                                              message: AppStrings
                                                  .alreadyinWishlistMsg),
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    style: IconButton.styleFrom(
                                      backgroundColor: AppColors.grey400,
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(4),
                                      minimumSize: const Size(28, 28),
                                    ),
                                  )),

                              // Overlay info on bottom of image
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 00,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.grey100.withOpacity(0.85),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        product.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: AppColors.black,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            '\₹${product.price}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          const Spacer(),
                                          Icon(Icons.star,
                                              color: AppColors.yellow700,
                                              size: 18),
                                          const SizedBox(width: 4),
                                          Text(
                                            product.ratings.toString(),
                                            style: TextStyle(
                                                color: AppColors.grey700),
                                          ),
                                        ],
                                      ),
                                    ],
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
