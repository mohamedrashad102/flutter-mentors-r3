part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final LoginResponse loginResponse;

  const AuthSuccess(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}

class AuthFailure extends AuthState {
  final Failure failure;

  const AuthFailure(this.failure);

  @override
  List<Object> get props => [failure];
}

class RegisterSuccess extends AuthState {}

class VerificationSuccess extends AuthState {}
