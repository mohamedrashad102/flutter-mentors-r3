import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_products.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProducts getProductsUseCase;
  final GetCategories getCategoriesUseCase;

  HomeCubit({
    required this.getProductsUseCase,
    required this.getCategoriesUseCase,
  }) : super(HomeInitial());

  int _page = 1;
  final int _pageSize = 10;
  String? _searchTerm;

  Future<void> fetchInitialData({String? searchTerm}) async {
    emit(HomeLoading());
    _page = 1;
    _searchTerm = searchTerm;
    try {
      final categoriesResult = await getCategoriesUseCase();
      final productsResult = await getProductsUseCase(
        GetProductsParams(
          page: _page,
          pageSize: _pageSize,
          searchTerm: _searchTerm,
        ),
      );

      categoriesResult.fold((failure) => emit(HomeError(failure.message)), (
        categories,
      ) {
        productsResult.fold((failure) => emit(HomeError(failure.message)), (
          products,
        ) {
          _page++;
          emit(
            HomeLoaded(
              categories: categories,
              products: products,
              hasReachedMax: products.length < _pageSize,
            ),
          );
        });
      });
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> fetchMoreProducts() async {
    if (state is HomeLoaded && !(state as HomeLoaded).hasReachedMax) {
      final currentState = state as HomeLoaded;
      try {
        final result = await getProductsUseCase(
          GetProductsParams(
            page: _page,
            pageSize: _pageSize,
            searchTerm: _searchTerm,
          ),
        );
        result.fold((failure) => emit(HomeError(failure.message)), (
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
        emit(HomeError(e.toString()));
      }
    }
  }
}
