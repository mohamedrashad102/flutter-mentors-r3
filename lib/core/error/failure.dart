import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final Map<String, dynamic>? errorDetails;

  const Failure(this.message, {this.errorDetails});

  @override
  List<Object?> get props => [message, errorDetails];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.errorDetails});
}

class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.errorDetails});
}
