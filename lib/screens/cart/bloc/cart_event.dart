part of 'cart_bloc.dart';

sealed class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  final int quantity;

  AddToCart({required this.product, this.quantity = 1});
}

class RemoveFromCart extends CartEvent {
  final Product product;
  final int quantity;

  RemoveFromCart({required this.product, this.quantity = 1});
}

class UpdateQuantity extends CartEvent {
  final int productId;
  final int newQuantity;

  UpdateQuantity({required this.productId, required this.newQuantity});
}
