import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, List<Product>>> call(GetProductsParams params) async {
    return await repository.getProducts(
      searchTerm: params.searchTerm,
      category: params.category,
      minPrice: params.minPrice,
      maxPrice: params.maxPrice,
      isInStock: params.isInStock,
      sortBy: params.sortBy,
      sortOrder: params.sortOrder,
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}

class GetProductsParams extends Equatable {
  final String? searchTerm;
  final String? category;
  final int? minPrice;
  final int? maxPrice;
  final bool? isInStock;
  final String? sortBy;
  final String? sortOrder;
  final int? page;
  final int? pageSize;

  const GetProductsParams({
    this.searchTerm,
    this.category,
    this.minPrice,
    this.maxPrice,
    this.isInStock,
    this.sortBy,
    this.sortOrder,
    this.page,
    this.pageSize,
  });

  @override
  List<Object?> get props => [
    searchTerm,
    category,
    minPrice,
    maxPrice,
    isInStock,
    sortBy,
    sortOrder,
    page,
    pageSize,
  ];
}
