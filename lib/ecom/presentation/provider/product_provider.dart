import 'package:ecom_app/ecom/domain/entities/product_entity.dart';
import 'package:ecom_app/ecom/domain/usecases/get_product_usecase.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final GetProductsUseCase _getProductsUseCase;

  ProductProvider(this._getProductsUseCase);

  List<ProductEntity> _products = [];
  List<ProductEntity> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;


// to fetch the products
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    final result = await _getProductsUseCase.call();

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners(); // notify to the ui after getting error
      },
      (productsList) {
        _products = productsList;
        _isLoading = false;
        notifyListeners();  // notify to the ui after getting product list
      },
    );
  }
}
