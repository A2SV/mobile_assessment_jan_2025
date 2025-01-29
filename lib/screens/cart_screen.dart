import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  double totalPrice(CartProvider cartProvider) {
    double total = 0;
    for (var item in cartProvider.cart.items) {
      total += (item.product.price * item.quantity);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (cartProvider.cart.items.isEmpty)
            Expanded(
              child: Center(
                child: Text("No Item found in cart"),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.cart.items.length,
                itemBuilder: (ctx, i) => CartItemWidget(
                  cartItem: cartProvider.cart.items[i],
                ),
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
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // TODO: Replace with actual total price calculation
                      Text(
                        totalPrice(cartProvider).toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: cartProvider.cart.items.isEmpty
                        ? null
                        : () {
                            // TODO: Implement checkout flow
                            // 1. Show a confirmation dialog
                            // 2. Clear the cart if confirmed
                            // 3. Show a success message (SnackBar)
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text("Checkout"),
                                content:
                                    Text('Are you sure you want to order?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      cartProvider.clearCart();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Order placed successfully!',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Yes',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(color: Colors.green),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[900],
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'ORDER NOW',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
