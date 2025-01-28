part of 'products_bloc.dart';

enum ProductsStatus { inital, loading, refreshing, loaded, error }

final class ProductsState {
  const ProductsState(
      {this.products = const [],
      this.status = ProductsStatus.inital,
      this.errorMessage = ""});

  final List<Product> products;
  final String errorMessage;
  final ProductsStatus status;

  ProductsState copyWith(
      {ProductsStatus? status, List<Product>? products, String? errorMessage}) {
    return ProductsState(
        products: products ?? this.products,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  List<Object> get props => [status, products, errorMessage];

  @override
  String toString() {
    return '''ProductsState { status: $status, errorMessage: $errorMessage, products: $products }''';
  }
}
