import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/product_model.dart';
import '../repository/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(ProductsState()) {
    on<FetchProducts>(_onFetchProducts);
  }

  final ProductsRepository _productsRepository;

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductsState> emitter) async {
    try {
      emit(state.copyWith(status: ProductsStatus.loading));
      List<Product> products = await _productsRepository.getProducts();

      emit(state.copyWith(status: ProductsStatus.loaded, products: products));
    } catch (e) {
      emit(state.copyWith(
          status: ProductsStatus.error, errorMessage: e.toString()));
    }
  }
}
