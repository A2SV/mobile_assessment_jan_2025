part of 'cart_bloc.dart';

enum CartStatus { initial, added, removed, updated, error }

final class CartState {
  const CartState(
      {this.cart = const [],
      this.status = CartStatus.initial,
      this.errorMessage = "",
      this.cartItem});

  final CartStatus status;
  final List<CartItem> cart;
  final CartItem? cartItem;
  final String errorMessage;

  CartState copyWith(
      {CartStatus? status,
      List<CartItem>? cart,
      String? errorMessage,
      CartItem? cartItem}) {
    return CartState(
        cart: cart ?? this.cart,
        status: status ?? this.status,
        cartItem: cartItem ?? this.cartItem,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  List<Object> get props =>
      [status, cart, errorMessage, cartItem ?? CartItem.empty];

  @override
  String toString() {
    return '''CartState { status: $status, errorMessage: $errorMessage, cartItems: $cart, cartItem: $cartItem }''';
  }
}
