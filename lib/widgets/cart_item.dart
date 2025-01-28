import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/constants/app_sizes.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    // TODO: don't remove the dismissible widget
    // use onDismissed method  for removing an item from the cart
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

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
        // TODO:  remove an item from the cart
        // and make sure the item is removed from the cart
        cartProvider.removeFromCart(cartItem.product.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item removed from cart')),
        );
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
              subtitle: SizedBox(
                  width: 150,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          cartProvider.updateQuantity(
                              cartItem.product.id, cartItem.quantity + 1);
                        },
                      ),
                      gapW4,
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          cartProvider.updateQuantity(
                              cartItem.product.id, cartItem.quantity - 1);
                        },
                      ),
                      Text(
                          'Total: \$${cartItem.product.price * cartItem.quantity}'),
                    ],
                  )),

              trailing: Text('${cartItem.quantity} x'),
              // TODO:  add buttons to increase or decrease the quantity of the item in the cart
            ),
          )),
    );
  }
}
