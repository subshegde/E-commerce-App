import 'package:ecom_app/ecom/core/constants/assets/app_icons.dart';
import 'package:ecom_app/ecom/core/constants/assets/app_images.dart';
import 'package:ecom_app/ecom/core/constants/strings/app_strings.dart';
import 'package:ecom_app/ecom/core/constants/theme/app_colors.dart';
import 'package:ecom_app/ecom/core/messages/message.dart';
import 'package:ecom_app/ecom/domain/entities/product_details_entity.dart';
import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
import 'package:ecom_app/ecom/presentation/provider/cart_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/product_details_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/wishlist_provider.dart';
import 'package:ecom_app/ecom/presentation/widgets/appbar.dart';
import 'package:flexi_productimage_slider/flexi_productimage_slider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailScreen extends StatefulWidget {
  final String id;

  const ProductDetailScreen({super.key, required this.id});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late CartProvider cartProvider;
  late WishlistProvider wishlistProvider;
  ProductEntity? productEntity;

@override
void initState() {
  super.initState();
  cartProvider = Provider.of<CartProvider>(context, listen: false);
  wishlistProvider = Provider.of<WishlistProvider>(context, listen: false);

  final productDetailsProvider = Provider.of<ProductDetailsProvider>(context, listen: false);

  if (productDetailsProvider.productDetail == null || 
      productDetailsProvider.productDetail!.asin != widget.id) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productDetailsProvider.fetchProductDetails(widget.id);
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Scaffold(
            appBar: CustomAppBar(),
            backgroundColor: AppColors.white,
            body: Center(child: LoadingAnimationWidget.discreteCircle(
                                        color: AppColors.primary,
                                        secondRingColor: Colors.grey,
                                        thirdRingColor: AppColors.black,
                                        size: 30,
                                       )),);
                  }
        if (provider.productDetail == null) {
          return  Scaffold(
            appBar: CustomAppBar(),
            backgroundColor: AppColors.white,
            body: const Center(child: Text('Product Not Found!')),);
        }

        productEntity = convertToProductEntity(provider.productDetail);

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    provider.productDetail!.productPhotos.isNotEmpty
                        ? flexiProductimageSlider(
                            arrayImages: provider.productDetail!.productPhotos ?? [],
                            sliderStyle: SliderStyle.nextToSlider,
                            aspectRatio: .8,
                            boxFit: BoxFit.cover,
                            selectedImagePosition: 0,
                            thumbnailAlignment: ThumbnailAlignment.bottom,
                            thumbnailBorderType: ThumbnailBorderType.all,
                            thumbnailBorderWidth: 1.5,
                            thumbnailBorderRadius: 50,
                            thumbnailWidth: 55,
                            thumbnailHeight: 55,
                            thumbnailBorderColor: AppColors.blue,
                            onTap: (index) {},
                          )
                        : Hero(
                            tag: productEntity?.id ?? '',
                            child: Container(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: productEntity?.image != null &&
                                          productEntity!.image!.isNotEmpty
                                      ? NetworkImage(productEntity!.image!)
                                      : const AssetImage(AppImages.placeholder) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: buildIconButton(
                        icon: Icons.favorite_border,
                        onPressed: () {
                          if (productEntity != null &&
                          !wishlistProvider.wishlistItems.any((item) => item.id == productEntity!.id)) {
                          wishlistProvider.addToWishlist(productEntity!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar.get(
                              message: AppStrings.addItemToWishListMsg
                            ),
                          );
                        } else if (productEntity != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackBar.get(
                              message: AppStrings.alreadyinWishlistMsg,
                            ),
                          );
                        }

                        },
                      ),
                    ),
                    Positioned(
                      top: 65,
                      right: 10,
                      child: buildIconButton(
                        icon: Icons.share,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    provider.productDetail!.productTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (productEntity != null) buildRatingRow(provider.productDetail),
                const SizedBox(height: 5),
                provider.productDetail!.salesVolume.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(left: 19),
                        child: Text("(${provider.productDetail!.salesVolume})",
                            style: const TextStyle(color: AppColors.green)),
                      )
                    : const SizedBox(),
                const SizedBox(height: 7),
                if (productEntity != null) buildPriceRow(provider.productDetail),
                const SizedBox(height: 12),
                if (provider.productDetail?.aboutProduct != null &&
                    provider.productDetail!.aboutProduct.isNotEmpty) ...[
                  const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "About Product",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...provider.productDetail!.aboutProduct
                      .asMap()
                      .entries
                      .map((entry) {
                    int index = entry.key;
                    String item = entry.value;

                    List<String> parts = item.split(":");
                    String key = parts.length > 1 ? parts[0] : "";
                    String description =
                        parts.length > 1 ? parts.sublist(1).join(":") : "";

                    if (key.isNotEmpty && description.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "$key: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.grey700,
                                ),
                              ),
                              TextSpan(
                                text: description,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.grey700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }).toList(),
                ],
                const SizedBox(height: 20),
              ],
            ),
          ),
          bottomNavigationBar: provider.productDetail == null
              ? const SizedBox.shrink()
              : buildBottomBar(provider.productDetail!),
        );
      },
    );
  }

  Widget buildIconButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey300,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.grey800),
        onPressed: onPressed,
      ),
    );
  }

  Widget buildRatingRow(ProductDetailsEntity? product) {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      child: Row(
        children: [
          Icon(Icons.star, color: AppColors.yellow700, size: 20),
          const SizedBox(width: 5),
          Text(
            product!.startRatings.toString(),
            style: const TextStyle(color: Colors.black38),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '${product!.productNumRatings} ratings',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPriceRow(ProductDetailsEntity? product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                "${product!.productOriginalPrice?.toString() ?? ""}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "\₹${product!.productPrice?.toString() ?? ""}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget buildBottomBar(ProductDetailsEntity product) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
             if (productEntity != null &&
                !cartProvider.cartItems.any((item) => item.product.id == productEntity!.id)) {
              cartProvider.addToCart(productEntity!);
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar.get(
                  message: AppStrings.addItemToCart,
                ),
              );
            } else if (productEntity != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar.get(
                  message: AppStrings.alreadyinCartMsg,
                ),
              );
            }
            },
            child: Container(
              height: 49,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Image.asset(AppIcons.addToCart, scale: 20),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.grey),
                padding: const EdgeInsets.symmetric(vertical: 12.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: const Text(
                AppStrings.empBtn,
                style: TextStyle(color: AppColors.grey, fontSize: 17),
              ),
            ),
          ),
          const SizedBox(width: 5),
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
                  AppStrings.buyNowBtn,
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                ),
              ),
            ),
          ),
       
 
        ],
      ),
    );
  }

    ProductEntity? convertToProductEntity(ProductDetailsEntity? productDetails) {
    if (productDetails == null) return null;
    String priceString = productDetails.productPrice;
    double price = double.parse(priceString.replaceAll(',', ''));
    return ProductEntity(
      id: productDetails.asin,
      title: productDetails.productTitle,
      description: productDetails.productDescription.isEmpty ? productDetails.aboutProduct[0] : productDetails.productDescription,
      price: price,
      image: productDetails.productPhoto,
      ratings: productDetails.startRatings,
      productNumRatings: productDetails.productNumRatings,
    );
  }
}

