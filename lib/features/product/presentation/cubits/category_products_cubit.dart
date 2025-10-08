import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';

part 'category_products_state.dart';

class CategoryProductsCubit extends Cubit<CategoryProductsState> {
  final GetProducts getProductsUseCase;

  CategoryProductsCubit({required this.getProductsUseCase})
    : super(CategoryProductsInitial());

  int _page = 1;
  final int _pageSize = 10;
  String? _categoryId;

  Future<void> fetchInitialProducts(String categoryId) async {
    emit(CategoryProductsLoading());
    _page = 1;
    _categoryId = categoryId;
    try {
      final result = await getProductsUseCase(
        GetProductsParams(
          category: _categoryId,
          page: _page,
          pageSize: _pageSize,
        ),
      );
      result.fold((failure) => emit(CategoryProductsError(failure.message)), (
        products,
      ) {
        _page++;
        emit(
          CategoryProductsLoaded(
            products: products,
            hasReachedMax: products.length < _pageSize,
          ),
        );
      });
    } catch (e) {
      emit(CategoryProductsError(e.toString()));
    }
  }

  Future<void> fetchMoreProducts() async {
    if (state is CategoryProductsLoaded &&
        !(state as CategoryProductsLoaded).hasReachedMax) {
      final currentState = state as CategoryProductsLoaded;
      try {
        final result = await getProductsUseCase(
          GetProductsParams(
            category: _categoryId,
            page: _page,
            pageSize: _pageSize,
          ),
        );
        result.fold((failure) => emit(CategoryProductsError(failure.message)), (
          newProducts,
        ) {
          _page++;
          emit(
            currentState.copyWith(
              products: currentState.products + newProducts,
              hasReachedMax: newProducts.length < _pageSize,
            ),
          );
        });
      } catch (e) {
        emit(CategoryProductsError(e.toString()));
      }
    }
  }
}
