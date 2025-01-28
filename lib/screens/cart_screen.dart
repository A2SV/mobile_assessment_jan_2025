import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

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
                        'totalPrice',
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
