import 'package:ecom_app/ecom/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.image,
    required super.ratings,
    required super.productNumRatings,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['asin'] ?? '',
      title: json['product_title'] ?? 'No Title',
      description: json['product_description']?.isNotEmpty == true ? json['product_description'] : 'No Description',
      price: _parsePrice(json['product_price'] ?? '0.00'),
      image: json['product_photo'] ?? '',
      ratings: json['product_star_rating'] ?? '0.0',
      productNumRatings: json['product_num_ratings'] ?? '0.0',
    );
  }

  static double _parsePrice(String priceString) {
    try {
      return double.parse(priceString.replaceAll(RegExp(r'[^0-9.]'), ''));
    } catch (e) {
      return 0.0;
    }
  }
}
