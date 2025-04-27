import 'package:dartz/dartz.dart';
import 'package:ecom_app/ecom/core/error/failure.dart';
import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}
