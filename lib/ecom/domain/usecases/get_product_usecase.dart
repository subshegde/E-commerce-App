import 'package:dartz/dartz.dart';
import 'package:ecom_app/ecom/core/error/failure.dart';
import 'package:ecom_app/ecom/core/usecase/usecase.dart';
import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
import 'package:ecom_app/ecom/domain/repositories/product_repo.dart';

class GetProductsUseCase implements UseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call() {
    return repository.getProducts();
  }
}
