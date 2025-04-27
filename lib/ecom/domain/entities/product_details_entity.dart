
class ProductDetailsEntity {
  final String asin;
  final String productTitle;
  final String productPrice;
  final String productOriginalPrice;
  final String currency;
  final String country;
  final int productNumRatings;
  final String startRatings;
  final String productPhoto;
  final String salesVolume;
  final List<String> aboutProduct;
  final String productDescription;
  final List<String> productPhotos;

  ProductDetailsEntity({
    required this.asin,
    required this.productTitle,
    required this.productPrice,
    required this.productOriginalPrice,
    required this.currency,
    required this.country,
    required this.productNumRatings,
    required this.productPhoto,
    required this.aboutProduct,
    required this.productDescription,
    required this.productPhotos,
    required this.startRatings,
    required this.salesVolume,
  });
}
