import 'package:dartz/dartz.dart';
import 'package:ecom_app/ecom/core/error/failure.dart';
import 'package:ecom_app/ecom/domain/entities/product_details_entity.dart';
import 'package:ecom_app/ecom/domain/repositories/product_details_repo.dart';
import 'package:ecom_app/ecom/core/usecase/usecase.dart';

class GetProductDetailsUseCase implements ProductDetailsUseCase<ProductDetailsEntity> {
  final ProductDetailsRepository repository;

  GetProductDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, ProductDetailsEntity>> call(String id) {
    return repository.getProductDetails(id);
  }
}
