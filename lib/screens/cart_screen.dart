import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/screens/checkout_screen.dart';
import 'package:mobile_assessment_jan_2025/widgets/checkout_card.dart';
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
      backgroundColor: Colors.white, // Updated background color
      appBar: AppBar(
        backgroundColor: Colors.white, // Updated AppBar color
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
          children: [
            const Text(
              "Your Cart",
              style: TextStyle(color: Colors.black),
            ),
            Consumer<CartProvider>(
              builder: (ctx, cart, child) => Text(
                "${cart.cart.items.length} items",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
        iconTheme:
            const IconThemeData(color: Colors.black), // Set AppBar icon color
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: cartProvider.cart.items.isEmpty
            ? const Center(
                child: Text('Your cart is empty'),
              )
            : ListView.builder(
                itemCount: cartProvider.cart.items.length,
                itemBuilder: (ctx, i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CartItemWidget(
                    cartItem: cartProvider.cart.items[i],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: const CheckoutCard(),
    );
  }
}
