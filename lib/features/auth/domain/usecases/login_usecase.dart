import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/login_response.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, LoginResponse>> call(LoginParams params) {
    return repository.login(params);
  }
}
