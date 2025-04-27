import 'package:ecom_app/ecom/domain/entities/product_details_entity.dart';

class ProductDetailsModel extends ProductDetailsEntity {
  ProductDetailsModel({
    required super.asin,
    required super.productTitle,
    required super.productPrice,
    required super.productOriginalPrice,
    required super.currency,
    required super.country,
    required super.productNumRatings,
    required super.productPhoto,
    required super.productDescription,
    required super.aboutProduct,
    required super.productPhotos,
    required super.startRatings,
    required super.salesVolume,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      asin: json['asin'] ?? '',
      productTitle: json['product_title'] ?? '',
      productPrice: json['product_price'] ?? '',
      productOriginalPrice: json['product_original_price'] ?? '',
      currency: json['currency'] ?? '',
      country: json['country'] ?? '',
      productNumRatings: json['product_num_ratings'] ?? 0,
      productPhoto: json['product_photo'] ?? '',
      productDescription: json['product_description'] ?? '',
      startRatings: json['product_star_rating'] ?? '',
      salesVolume: json['sales_volume'] ?? '',
      aboutProduct: List<String>.from(json['about_product'] ?? []),
      productPhotos: List<String>.from(json['product_photos'] ?? []),
    );
  }
}
