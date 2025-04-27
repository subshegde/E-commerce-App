import 'package:dartz/dartz.dart';

import '../error/failure.dart';

abstract class UseCase<Type> {
  Future<Either<Failure, Type>> call();
}

abstract class ProductDetailsUseCase<Type> {
  Future<Either<Failure, Type>> call(String id);
}