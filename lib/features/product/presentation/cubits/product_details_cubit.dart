import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product_by_id.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductById getProductByIdUseCase;

  ProductDetailsCubit({required this.getProductByIdUseCase})
    : super(ProductDetailsInitial());

  Future<void> fetchProductDetails(String id) async {
    emit(ProductDetailsLoading());
    final result = await getProductByIdUseCase(id);
    result.fold(
      (failure) => emit(ProductDetailsError(failure.message)),
      (product) => emit(ProductDetailsLoaded(product)),
    );
  }
}
