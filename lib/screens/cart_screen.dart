import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/app/common/app_text_style.dart';
import 'package:mobile_assessment_jan_2025/app/common/ui_helpers.dart';
import 'package:mobile_assessment_jan_2025/widgets/custom_button.dart';
import 'package:mobile_assessment_jan_2025/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    showConfimrationDialog() {
      return CustomDialog.show(
          context: context,
          dismissible: false,
          widget: Container(
            padding: EdgeInsets.all(middleSize),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(middleSize)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Are you sure you want to order the product?',
                    style: bold),
                verticalSpaceMiddle,
                Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text: 'No',
                      color: Colors.grey,
                    )),
                    horizontalSpaceSmall,
                    Expanded(
                      child: CustomButton(
                          onTap: () {
                            // confirmed.
                            Navigator.pop(context);
                            // clear the cart
                            cartProvider.clearCart();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Order placed successfully!')),
                            );
                            Navigator.pop(context);
                          },
                          text: 'Yes'),
                    )
                  ],
                )
              ],
            ),
          ));
    }

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
                      Text('Total', style: extraBold.copyWith(fontSize: 20)),
                      Text(
                        '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    onTap: cartProvider.cart.items.isEmpty
                        ? null
                        : () {
                            // TODO: Implement checkout flow
                            showConfimrationDialog();
                            // 1. Show a confirmation dialog
                            // 2. Clear the cart if confirmed
                            // 3. Show a success message (SnackBar)
                          },
                    text: 'ORDER NOW',
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
