import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/local_auth_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/refresh_token_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/domain/usecases/verify_email_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/product/data/datasources/product_remote_data_source.dart';
import '../../features/product/data/repositories/product_repository_impl.dart';
import '../../features/product/domain/repositories/product_repository.dart';
import '../../features/product/domain/usecases/get_categories.dart';
import '../../features/product/domain/usecases/get_product_by_id.dart';
import '../../features/product/domain/usecases/get_products.dart';
import '../../features/product/presentation/cubits/category_products_cubit.dart';
import '../../features/product/presentation/cubits/home_cubit.dart';
import '../../features/product/presentation/cubits/product_details_cubit.dart';
import '../network/dio_helper.dart';

final di = GetIt.instance;

Future<void> setupLocator() async {
  // Core
  final pref = await SharedPreferences.getInstance();
  di.registerSingleton<SharedPreferences>(pref);

  final storage = const FlutterSecureStorage();
  di.registerSingleton<FlutterSecureStorage>(storage);

  final dioHelper = DioHelper.instance;
  di.registerSingleton<DioHelper>(dioHelper);

  // Features - Auth
  // Data sources
  di.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dioHelper: di()),
  );

  di.registerLazySingleton<LocalAuthDataSource>(
    () => LocalAuthDataSource(sharedPreferences: di(), storage: di()),
  );

  // Repositories
  di.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: di()),
  );

  // Use cases
  di.registerFactory(() => RegisterUseCase(di()));
  di.registerFactory(() => LoginUseCase(di()));
  di.registerFactory(() => VerifyEmailUseCase(di()));
  di.registerFactory(() => RefreshTokenUseCase(di()));

  // Cubits
  di.registerFactory(
    () => AuthCubit(
      loginUseCase: di(),
      registerUseCase: di(),
      verifyEmailUseCase: di(),
    ),
  );

  // Features - Product
  // Data sources
  di.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dioHelper: di()),
  );

  // Repositories
  di.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: di()),
  );

  // Use cases
  di.registerFactory(() => GetProducts(di()));
  di.registerFactory(() => GetProductById(di()));
  di.registerFactory(() => GetCategories(di()));

  // Cubits
  di.registerFactory(
    () => HomeCubit(getProductsUseCase: di(), getCategoriesUseCase: di()),
  );
  di.registerFactory(() => ProductDetailsCubit(getProductByIdUseCase: di()));
  di.registerFactory(() => CategoryProductsCubit(getProductsUseCase: di()));

  dioHelper.initialize(
    baseUrl: 'https://accessories-eshop.runasp.net/api',
    accessToken: await di<LocalAuthDataSource>().accessToken,
    refreshToken: await di<LocalAuthDataSource>().refreshToken,
    onRefreshToken: (refreshToken) async {
      final usecase = di<RefreshTokenUseCase>();
      final result = await usecase(
        RefreshTokenParams(refreshToken: refreshToken),
      );

      return result.fold(
        (failure) => throw failure, // TODO: Handle failure
        (loginResponse) {
          final token = TokenResponse(
            accessToken: loginResponse.accessToken,
            refreshToken: loginResponse.refreshToken,
          );
          di<LocalAuthDataSource>().saveTokens(token);
          return token;
        },
      );
    },
  );
}
