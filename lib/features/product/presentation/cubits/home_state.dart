part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Product> products;
  final List<Category> categories;
  final bool hasReachedMax;

  const HomeLoaded({
    required this.products,
    required this.categories,
    this.hasReachedMax = false,
  });

  HomeLoaded copyWith({
    List<Product>? products,
    List<Category>? categories,
    bool? hasReachedMax,
  }) {
    return HomeLoaded(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [products, categories, hasReachedMax];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
