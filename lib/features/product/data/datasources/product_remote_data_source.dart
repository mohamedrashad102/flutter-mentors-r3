import 'package:dio/dio.dart';

import '../../../../core/error/dio_exception_handler.dart';
import '../../../../core/network/dio_helper.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({
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

  Future<ProductModel> getProductById(String id);

  Future<List<CategoryModel>> getCategories();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioHelper dioHelper;

  ProductRemoteDataSourceImpl({required this.dioHelper});

  @override
  Future<List<ProductModel>> getProducts({
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
      final response = await dioHelper.get(
        '/products',
        data: {
          'searchTerm': searchTerm,
          'category': category,
          'minPrice': minPrice,
          'maxPrice': maxPrice,
          'isInStock': isInStock,
          'sortBy': sortBy,
          'sortOrder': sortOrder,
          'page': page,
          'pageSize': pageSize,
        }..removeWhere((key, value) => value == null),
      );
      return (response.data['items'] as List)
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList();
    } on DioException catch (e) {
      throw DioExceptionHandler.handleException(e);
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await dioHelper.get('/products/$id');
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioExceptionHandler.handleException(e);
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dioHelper.get('/categories');
      return (response.data['categories'] as List)
          .map((categoryJson) => CategoryModel.fromJson(categoryJson))
          .toList();
    } on DioException catch (e) {
      throw DioExceptionHandler.handleException(e);
    }
  }
}
