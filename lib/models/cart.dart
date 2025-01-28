import '../screens/products/model/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  static CartItem empty = CartItem(quantity: 0, product: Product.empty());
}

class Cart {
  List<CartItem> items = [];
}
