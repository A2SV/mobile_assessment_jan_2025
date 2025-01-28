import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/cart_item.dart';
import '../../../widgets/dialogs.dart';
import '../bloc/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          double totalPrice = state.cart.fold(
              0, (sum, cart) => sum + ((cart.product.price) * cart.quantity));

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.cart.length,
                  itemBuilder: (ctx, i) => CartItemWidget(
                    cartItem: state.cart[i],
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
                            totalPrice.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: state.cart.isEmpty
                            ? null
                            : () async {
                                bool? result =
                                    await Dialogs().showConfirmDialog(context);
                                if (result != null && result) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Successfully placed order!')),
                                  );
                                }
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
          );
        },
      ),
    );
  }
}
