// import 'package:dartz/dartz.dart';
// import 'package:ecom_app/ecom/data/sources/product_remote_datasource.dart';
// import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
// import 'package:ecom_app/ecom/domain/repositories/product_repo.dart';
// import '../../core/error/failure.dart';
// import '../models/product_model.dart';

// class ProductRepositoryImpl implements ProductRepository {
//   final ProductApiService apiService;

//   ProductRepositoryImpl(this.apiService);

//   @override
//   Future<Either<Failure, List<ProductEntity>>> getProducts() async {
//     try {
//       final response = await apiService.fetchProducts();
//       final List data = response.data;
//       List<ProductEntity> products = data.map((e) => ProductModel.fromJson(e)).toList();
//       return Right(products);
//     } catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }
// }
import 'package:dartz/dartz.dart';
import 'package:ecom_app/ecom/core/error/failure.dart';
import 'package:ecom_app/ecom/data/models/product_model.dart';
import 'package:ecom_app/ecom/data/sources/product_remote_datasource.dart';
import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
import 'package:ecom_app/ecom/domain/repositories/product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApiService apiService;

  ProductRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final response = await apiService.fetchProducts();

      final Map<String, dynamic> data = response.data;

      final List<dynamic> productData = data['data']['best_sellers']; 

      List<ProductEntity> products = productData.map((e) => ProductModel.fromJson(e)).toList();

      return Right(products);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
