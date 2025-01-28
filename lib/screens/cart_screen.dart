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
    final totalPrice = cartProvider.cart.items
        .fold(0.0, (sum, item) => sum + item.product.price * item.quantity);

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
                      Text(
                        '$totalPrice',
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
                            showAnimatedDialog(
                                context: context,
                                child: confirmationDialogue(context));
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

  void showAnimatedDialog(
      {required BuildContext context, required Widget child}) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: Stack(children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  color: Colors.black45,
                ),
              ),
              SlideTransition(
                position: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
                    .animate(CurvedAnimation(
                        parent: animation, curve: Curves.easeOut)),
                child: child,
              ),
            ]),
          );
        }));
  }

  Widget confirmationDialogue(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0XFFFFFFFF),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.grey, width: 1)),
      child: IntrinsicWidth(
        stepWidth: double.infinity,
        child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.only(right: 12, left: 12, top: 16, bottom: 42),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Color(0XFF000000),
                          size: 24,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 36),
                  child: Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Please Confirm Checkout',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0XFF000000)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9.5),
                  child: ElevatedButton(
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .clearCart();
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Order placed successfully!'),
                          duration: const Duration(seconds: 2),
                        ));
                      },
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.green),
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
