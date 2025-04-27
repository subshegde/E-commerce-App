import 'package:dartz/dartz.dart';
import 'package:ecom_app/ecom/core/error/failure.dart';
import 'package:ecom_app/ecom/domain/entities/product_details_entity.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(String id);
}
