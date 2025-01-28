import 'package:bloc/bloc.dart';

import '../../../models/cart.dart';
import '../../products/model/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emitter) {
    try {
      final _cart = List.of(state.cart);
      final existingItem = _cart.firstWhere(
        (item) => item.product.id == event.product.id,
        orElse: () => CartItem(product: Product.empty(), quantity: 0),
      );

      if (existingItem.product.id != -1) {
        existingItem.quantity += event.quantity;
      } else {
        _cart.add(CartItem(product: event.product, quantity: event.quantity));
      }
      emit(state.copyWith(status: CartStatus.added, cart: _cart));
    } catch (_) {
      emit(state.copyWith(
          status: CartStatus.error, errorMessage: "Could not add to cart"));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emitter) {
    try {
      final _cart = List.of(state.cart);
      final existingItem = _cart.firstWhere(
        (item) => item.product.id == event.product.id,
        orElse: () => CartItem(product: Product.empty(), quantity: 0),
      );

      if (existingItem.product.id != -1) {
        _cart.remove(existingItem);
      }
      emit(state.copyWith(status: CartStatus.removed, cart: _cart));
    } catch (_) {
      emit(state.copyWith(
          status: CartStatus.error, errorMessage: "Could not add to cart"));
    }
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emitter) {
    try {
      final _cart = List.of(state.cart);
      final existingItem = _cart.firstWhere(
        (item) => item.product.id == event.productId,
        orElse: () => CartItem(product: Product.empty(), quantity: 0),
      );

      if (existingItem.product.id != -1) {
        existingItem.quantity = event.newQuantity;
      }
      emit(state.copyWith(status: CartStatus.updated));
    } catch (_) {
      emit(state.copyWith(
          status: CartStatus.error, errorMessage: "Could not add to cart"));
    }
  }
}
