import 'package:ecom_app/ecom/domain/entities/product_entity.dart';

abstract class CartRepository {
  Future<void> addToCart(ProductEntity product);
  Future<void> removeFromCart(ProductEntity product);
}
