// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/cart.dart';
// import '../providers/cart_provider.dart';

// class CartItemWidget extends StatelessWidget {
//   final CartItem cartItem;

//   const CartItemWidget({super.key, required this.cartItem});

//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//       key: ValueKey(cartItem.product.id),
//       background: Container(
//         decoration: BoxDecoration(
//           color: Colors.red.shade100,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         alignment: Alignment.centerRight,
//         padding: const EdgeInsets.only(right: 20),
//         margin: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 8,
//         ),
//         child: Icon(
//           Icons.delete_outline_rounded,
//           color: Colors.red.shade700,
//           size: 32,
//         ),
//       ),
//       direction: DismissDirection.endToStart,
//       onDismissed: (direction) {
//         Provider.of<CartProvider>(context, listen: false)
//             .removeFromCart(cartItem.product.id);

//         // Show a snackbar with undo option
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: const Text('Item removed from cart'),
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             action: SnackBarAction(
//               label: 'UNDO',
//               onPressed: () {
//                 Provider.of<CartProvider>(context, listen: false)
//                     .addToCart(cartItem.product, quantity: cartItem.quantity);
//               },
//             ),
//           ),
//         );
//       },
//       child: Card(
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//           side: BorderSide(color: Colors.grey.shade200),
//         ),
//         margin: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 8,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Row(
//             children: [
//               // Product Image
//               Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding: const EdgeInsets.all(8),
//                 child: Image.network(
//                   cartItem.product.image,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               // Product Details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       cartItem.product.title,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '\$${cartItem.product.price.toStringAsFixed(2)}',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green.shade700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 16),
//               // Quantity Controls
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(
//                         Icons.remove_rounded,
//                         color: cartItem.quantity > 1
//                             ? Colors.black
//                             : Colors.red.shade700,
//                       ),
//                       onPressed: () {
//                         Provider.of<CartProvider>(context, listen: false)
//                             .updateQuantity(
//                                 cartItem.product.id, cartItem.quantity - 1);
//                       },
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 8,
//                       ),
//                       child: Text(
//                         '${cartItem.quantity}',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.add_rounded),
//                       onPressed: () {
//                         Provider.of<CartProvider>(context, listen: false)
//                             .updateQuantity(
//                                 cartItem.product.id, cartItem.quantity + 1);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Icon(
          Icons.delete_outline_rounded,
          color: Colors.red.shade700,
          size: 32,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false)
            .removeFromCart(cartItem.product.id);

        // Show a snackbar with undo option
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Item removed from cart'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false)
                    .addToCart(cartItem.product, quantity: cartItem.quantity);
              },
            ),
          ),
        );
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Product Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(8),
                child: Image.network(
                  cartItem.product.image,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.product.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${cartItem.product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Quantity Controls
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove_rounded,
                        color: cartItem.quantity > 1
                            ? Colors.black
                            : Colors.red.shade700,
                      ),
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .updateQuantity(
                                cartItem.product.id, cartItem.quantity - 1);
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Text(
                        '${cartItem.quantity}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_rounded),
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .updateQuantity(
                                cartItem.product.id, cartItem.quantity + 1);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
