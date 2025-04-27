class ProductEntity {
  final dynamic id;
  final String title;
  final String description;
  final dynamic price;
  final String image;
  final dynamic ratings;
  final dynamic productNumRatings;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.ratings,
    required this.productNumRatings,
  });
}
