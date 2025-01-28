import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });
}

class Cart {
  List<CartItem> items = [];
  double get totalPrice {
    return items.fold(0.0, (total, item) => total + (item.product.price * item.quantity));
  }
}
