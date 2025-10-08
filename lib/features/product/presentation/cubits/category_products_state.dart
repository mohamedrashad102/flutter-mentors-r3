part of 'category_products_cubit.dart';

abstract class CategoryProductsState extends Equatable {
  const CategoryProductsState();

  @override
  List<Object> get props => [];
}

class CategoryProductsInitial extends CategoryProductsState {}

class CategoryProductsLoading extends CategoryProductsState {}

class CategoryProductsLoaded extends CategoryProductsState {
  final List<Product> products;
  final bool hasReachedMax;

  const CategoryProductsLoaded({
    required this.products,
    this.hasReachedMax = false,
  });

  CategoryProductsLoaded copyWith({
    List<Product>? products,
    bool? hasReachedMax,
  }) {
    return CategoryProductsLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [products, hasReachedMax];
}

class CategoryProductsError extends CategoryProductsState {
  final String message;

  const CategoryProductsError(this.message);

  @override
  List<Object> get props => [message];
}
