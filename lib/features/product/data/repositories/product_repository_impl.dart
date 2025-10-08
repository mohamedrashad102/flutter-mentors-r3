import 'package:dartz/dartz.dart';
import '../../../../core/error/dio_exception_handler.dart';
import '../../../../core/error/failure.dart';
import '../datasources/product_remote_data_source.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
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
  }) async {
    try {
      final products = await remoteDataSource.getProducts(
        searchTerm: searchTerm,
        category: category,
        minPrice: minPrice,
        maxPrice: maxPrice,
        isInStock: isInStock,
        sortBy: sortBy,
        sortOrder: sortOrder,
        page: page,
        pageSize: pageSize,
      );
      return Right(products);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message, errorDetails: e.errorDetails));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    try {
      final product = await remoteDataSource.getProductById(id);
      return Right(product);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message, errorDetails: e.errorDetails));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message, errorDetails: e.errorDetails));
    }
  }
}
