
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Column(
        children: [
          Expanded(
            child: cartProvider.cart.items.isEmpty
                ? const Center(child: Text('No items in the cart'))
                : ListView.builder(
                    itemCount: cartProvider.cart.items.length,
                    itemBuilder: (ctx, i) {
                      var cartItem = cartProvider.cart.items[i];

                      return Dismissible(
                        key: ValueKey(cartItem.product.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete,
                              color: Colors.white, size: 30),
                        ),
                        onDismissed: (_) {
                          cartProvider.removeFromCart(cartItem.product.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Item removed from cart')),
                          );
                        },
                        child: ListTile(
                          leading: Image.network(cartItem.product.image,
                              width: 50, height: 50),
                          title: Text(cartItem.product.title),
                          subtitle: Text(
                              'Total: \$${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline,
                                    color: Colors.red),
                                onPressed: () => cartProvider.updateQuantity(
                                    cartItem.product.id, cartItem.quantity - 1),
                              ),
                              Text('${cartItem.quantity}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline,
                                    color: Colors.green),
                                onPressed: () => cartProvider.updateQuantity(
                                    cartItem.product.id, cartItem.quantity + 1),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: cartProvider.cart.items.isEmpty
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Confirm Order'),
                                content: const Text(
                                    'Do you want to place the order?'),
                                actions: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () => Navigator.of(ctx).pop(),
                                  ),
                                  TextButton(
                                    child: const Text('Confirm'),
                                    onPressed: () {
                                      cartProvider.clearCart();
                                      Navigator.of(ctx).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Order placed successfully!')),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                    child: const Text('ORDER NOW'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
