import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
import 'package:ecom_app/ecom/domain/repositories/add_to_cart.dart';

class AddToCart {
  final CartRepository cartRepository;

  AddToCart(this.cartRepository);

  Future<void> execute(ProductEntity product) {
    return cartRepository.addToCart(product);
  }
}
