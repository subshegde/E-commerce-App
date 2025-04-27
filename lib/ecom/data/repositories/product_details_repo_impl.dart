import 'package:dartz/dartz.dart';
import 'package:ecom_app/ecom/core/error/failure.dart';
import 'package:ecom_app/ecom/data/models/product_details_model.dart';
import 'package:ecom_app/ecom/data/sources/product_details_detasource.dart';
import 'package:ecom_app/ecom/domain/entities/product_details_entity.dart';
import 'package:ecom_app/ecom/domain/repositories/product_details_repo.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsApiService apiService;

  ProductDetailsRepositoryImpl(this.apiService);
@override
Future<Either<Failure, ProductDetailsEntity>> getProductDetails(String id) async {
  try {
    final response = await apiService.fetchProductDetails(id);
    final Map<String, dynamic> data = response.data;

    final Map<String, dynamic> productData = data['data']; 

    if (productData.isNotEmpty) {
      ProductDetailsEntity productDetail = ProductDetailsModel.fromJson(productData);
      return Right(productDetail);
    } else {
      return Left(ServerFailure("No product details found"));
    }
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}

}
