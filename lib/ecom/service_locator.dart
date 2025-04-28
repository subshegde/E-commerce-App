import 'package:ecom_app/ecom/data/repositories_impl/product_details_repo_impl.dart';
import 'package:ecom_app/ecom/data/repositories_impl/product_repo_impl.dart';
import 'package:ecom_app/ecom/data/sources/product_details_detasource.dart';
import 'package:ecom_app/ecom/data/sources/product_remote_datasource.dart';
import 'package:ecom_app/ecom/domain/repositories/product_details_repo.dart';
import 'package:ecom_app/ecom/domain/repositories/product_repo.dart';
import 'package:ecom_app/ecom/domain/usecases/get_product_details_usecase.dart';
import 'package:ecom_app/ecom/domain/usecases/get_product_usecase.dart';
import 'package:ecom_app/ecom/presentation/provider/cart_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/product_details_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/product_provider.dart';
import 'package:ecom_app/ecom/presentation/provider/wishlist_provider.dart';
import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';

final sl = GetIt.instance;

Future setUpServiceLocator() async{
  // dio client
  sl.registerSingleton<DioClient>(DioClient());
  
  // api services
  sl.registerSingleton<ProductApiService>(ProductApiServiceImpl(sl()));
  sl.registerSingleton<ProductDetailsApiService>(ProductDetailsApiServiceImpl(sl()));

  // repositories
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl(sl()));
  sl.registerSingleton<ProductDetailsRepository>(ProductDetailsRepositoryImpl(sl()));

  // usecases
  sl.registerSingleton<GetProductsUseCase>(GetProductsUseCase(sl()));
  sl.registerSingleton<GetProductDetailsUseCase>(GetProductDetailsUseCase(sl()));
  
  // providers
  sl.registerFactory<ProductProvider>(() => ProductProvider(sl()));
  sl.registerFactory<CartProvider>(() => CartProvider());
  sl.registerFactory<WishlistProvider>(() => WishlistProvider());
  sl.registerFactory<ProductDetailsProvider>(() => ProductDetailsProvider(sl()));

}
