import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/login_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/verify_email_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;

  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required VerifyEmailUseCase verifyEmailUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _verifyEmailUseCase = verifyEmailUseCase,
       super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await _loginUseCase(
      LoginParams(email: email, password: password),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (loginResponse) => emit(AuthSuccess(loginResponse)),
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    emit(AuthLoading());
    final result = await _registerUseCase(
      RegisterParams(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      ),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(RegisterSuccess()),
    );
  }

  Future<void> verifyEmail({required String email, required String otp}) async {
    emit(AuthLoading());
    final result = await _verifyEmailUseCase(
      VerifyEmailParams(email: email, otp: otp),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(VerificationSuccess()),
    );
  }
}
