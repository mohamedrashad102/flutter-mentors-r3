import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/category.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    String? searchTerm,
    String? category,
    int? minPrice,
    int? maxPrice,
    bool? isInStock,
    String? sortBy,
    String? sortOrder,
    int? page,
    int? pageSize,
  });

  Future<Either<Failure, Product>> getProductById(String id);

  Future<Either<Failure, List<Category>>> getCategories();
}
