import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/category.dart';
import '../repositories/product_repository.dart';

class GetCategories {
  final ProductRepository repository;

  GetCategories(this.repository);

  Future<Either<Failure, List<Category>>> call() async {
    return await repository.getCategories();
  }
}
