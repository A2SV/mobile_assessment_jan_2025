import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
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
        Provider.of<CartProvider>(context, listen: false)
            .removeFromCart(cartItem.product.id);
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
            subtitle:
                Text('Total: \$${cartItem.product.price * cartItem.quantity}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .updateQuantity(
                            cartItem.product.id, cartItem.quantity - 1);
                  },
                ),
                Text('${cartItem.quantity} x'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .updateQuantity(
                            cartItem.product.id, cartItem.quantity + 1);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
