import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/login_response.dart';
import '../repositories/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  Future<Either<Failure, LoginResponse>> call(RefreshTokenParams params) {
    return repository.refreshToken(params);
  }
}
