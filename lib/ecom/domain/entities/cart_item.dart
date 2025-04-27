
import 'package:ecom_app/ecom/domain/entities/product_entity.dart';

class CartItem {
  final ProductEntity product;
  final int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  CartItem copyWith({
    ProductEntity? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
