import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/refresh_token_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/domain/usecases/verify_email_usecase.dart';
import '../network/token_storage.dart';
import '../network/dio_helper.dart';

final di = GetIt.instance;

Future<void> setupLocator() async {
  // Core
  final pref = await SharedPreferences.getInstance();
  di.registerSingleton<SharedPreferences>(pref);

  final dioHelper = DioHelper.instance;
  di.registerSingleton<DioHelper>(dioHelper);

  // Features - Auth
  // Data sources
  di.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dioHelper: di()),
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
  di.registerFactory(() => AuthCubit(
        loginUseCase: di(),
        registerUseCase: di(),
        verifyEmailUseCase: di(),
      ));

  dioHelper.initialize(
    baseUrl: 'https://accessories-eshop.runasp.net/api',
    accessToken: await TokenStorage.accessToken,
    refreshToken: await TokenStorage.refreshToken,
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
          TokenStorage.saveTokens(token);
          return token;
        },
      );
    },
  );
}
