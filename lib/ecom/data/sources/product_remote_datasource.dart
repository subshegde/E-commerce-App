import 'package:dio/dio.dart';
import 'package:ecom_app/ecom/core/constants/url/app_apiUrl.dart';
import '../../core/network/dio_client.dart';

abstract class ProductApiService {
  Future<Response> fetchProducts();
}

class ProductApiServiceImpl implements ProductApiService {
  final DioClient dioClient;

  ProductApiServiceImpl(this.dioClient);

  @override
  Future<Response> fetchProducts() async {
    return await dioClient.get(ApiUrl.productsUrl);
  }
}
