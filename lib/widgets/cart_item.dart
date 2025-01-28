import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/widgets/cart_calculator_widget.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    // TODO: don't remove the dismissible widget
    // use onDismissed method  for removing an item from the cart
    return Dismissible(
      key: ValueKey(cartItem.product.id),
      background: Container(
        color: Theme.of(context).indicatorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cartProvider.removeFromCart(cartItem.product.id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.network(cartItem.product.image),
              ),
            ),
            title: Text(cartItem.product.title),
            subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Total: \$${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}'),
                  CartCalculatorWidget(
                      onAdd: () => cartProvider.updateQuantity(
                          cartItem.product.id, cartItem.quantity + 1),
                      onSubstact: () => cartProvider.updateQuantity(
                          cartItem.product.id, cartItem.quantity - 1))
                ]),
            trailing: Text('${cartItem.quantity} x'),
          ),
        ),
      ),
    );
  }
}
