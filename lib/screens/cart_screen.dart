// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/cart_provider.dart';
// import '../widgets/cart_item.dart';

// class CartScreen extends StatelessWidget {
//   static const routeName = '/cart';

//   const CartScreen({super.key});

//   double _calculateTotal(CartProvider cartProvider) {
//     return cartProvider.cart.items
//         .fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
//   }

//   Future<bool?> _showCheckoutDialog(BuildContext context) async {
//     return showDialog<bool>(
//       context: context,
//       barrierColor: Colors.black.withOpacity(0.5),
//       builder: (ctx) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//         backgroundColor: Colors.white,
//         elevation: 8,
//         title: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.green.shade50,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(Icons.shopping_bag_outlined,
//                   color: Colors.green.shade600),
//             ),
//             const SizedBox(width: 12),
//             const Text(
//               'Checkout',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 24,
//               ),
//             ),
//           ],
//         ),
//         content: const Text(
//           'Would you like to proceed with your order?',
//           style: TextStyle(fontSize: 16, height: 1.5),
//         ),
//         actions: [
//           TextButton(
//             style: TextButton.styleFrom(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: Text(
//               'Cancel',
//               style: TextStyle(
//                 color: Colors.grey.shade700,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             onPressed: () => Navigator.of(ctx).pop(false),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green.shade600,
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: const Text(
//               'Confirm Order',
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//               ),
//             ),
//             onPressed: () => Navigator.of(ctx).pop(true),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       backgroundColor:
//           isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF8F9FA),
//       appBar: AppBar(
//         title: const Text(
//           'Shopping Cart',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 24,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: const Icon(Icons.arrow_back_ios_new, size: 20),
//           ),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: cartProvider.cart.items.isEmpty
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.shopping_cart_outlined,
//                     size: 80,
//                     color: Colors.grey.shade400,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Your cart is empty',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.grey.shade600,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Add items to start shopping',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey.shade500,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     itemCount: cartProvider.cart.items.length,
//                     itemBuilder: (ctx, i) => CartItemWidget(
//                       cartItem: cartProvider.cart.items[i],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(32),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 12,
//                         offset: const Offset(0, -4),
//                       ),
//                     ],
//                   ),
//                   padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
//                   child: SafeArea(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               'Total Amount',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xFF2D3436),
//                               ),
//                             ),
//                             Text(
//                               '\$${_calculateTotal(cartProvider).toStringAsFixed(2)}',
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.green.shade600,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                         ElevatedButton(
//                           onPressed: () async {
//                             final confirm = await _showCheckoutDialog(context);
//                             if (confirm == true && context.mounted) {
//                               cartProvider.clearCart();
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.check_circle_outline,
//                                         color: Colors.white,
//                                       ),
//                                       const SizedBox(width: 12),
//                                       const Text(
//                                         'Order placed successfully!',
//                                         style: TextStyle(fontSize: 16),
//                                       ),
//                                     ],
//                                   ),
//                                   backgroundColor: Colors.green.shade600,
//                                   behavior: SnackBarBehavior.floating,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(16),
//                                   ),
//                                   margin: const EdgeInsets.all(16),
//                                 ),
//                               );
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green.shade600,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                           ),
//                           child: const Text(
//                             'Proceed to Checkout',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  double _calculateTotal(CartProvider cartProvider) {
    return cartProvider.cart.items
        .fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  Future<bool?> _showCheckoutDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        elevation: 8,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.shopping_bag_outlined,
                  color: Colors.green.shade600),
            ),
            const SizedBox(width: 12),
            const Text(
              'Checkout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
        content: const Text(
          'Would you like to proceed with your order?',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () => Navigator.of(ctx).pop(false),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Confirm Order',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 20),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: cartProvider.cart.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add items to start shopping',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: cartProvider.cart.items.length,
                    itemBuilder: (ctx, i) => CartItemWidget(
                      cartItem: cartProvider.cart.items[i],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2D3436),
                              ),
                            ),
                            Text(
                              '\$${_calculateTotal(cartProvider).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            final confirm = await _showCheckoutDialog(context);
                            if (confirm == true && context.mounted) {
                              cartProvider.clearCart();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        'Order placed successfully!',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Colors.green.shade600,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  margin: const EdgeInsets.all(16),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Proceed to Checkout',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
