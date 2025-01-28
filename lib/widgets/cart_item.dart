import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/cart.dart';
import '../providers/cart_provider.dart';

// Add SVG icon strings or import them as assets if preferred
const trashIcon =
    '''<svg width="18" height="20" viewBox="0 0 18 20" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M10.7812 15.6604V7.16981C10.7812 6.8566 11.0334 6.60377 11.3438 6.60377C11.655 6.60377 11.9062 6.8566 11.9062 7.16981V15.6604C11.9062 15.9736 11.655 16.2264 11.3438 16.2264C11.0334 16.2264 10.7812 15.9736 10.7812 15.6604ZM6.09375 15.6604V7.16981C6.09375 6.8566 6.34594 6.60377 6.65625 6.60377C6.9675 6.60377 7.21875 6.8566 7.21875 7.16981V15.6604C7.21875 15.9736 6.9675 16.2264 6.65625 16.2264C6.34594 16.2264 6.09375 15.9736 6.09375 15.6604ZM15 16.6038C15 17.8519 13.9903 18.8679 12.75 18.8679H5.25C4.00969 18.8679 3 17.8519 3 16.6038V3.96226H15V16.6038ZM7.21875 1.50943C7.21875 1.30094 7.38656 1.13208 7.59375 1.13208H10.4062C10.6134 1.13208 10.7812 1.30094 10.7812 1.50943V2.83019H7.21875V1.50943ZM17.4375 2.83019H11.9062V1.50943C11.9062 0.677359 11.2331 0 10.4062 0H7.59375C6.76688 0 6.09375 0.677359 6.09375 1.50943V2.83019H0.5625C0.252187 2.83019 0 3.08302 0 3.39623C0 3.70943 0.252187 3.96226 0.5625 3.96226H1.875V16.6038C1.875 18.4764 3.38906 20 5.25 20H12.75C14.6109 20 16.125 18.4764 16.125 16.6038V3.96226H17.4375C17.7488 3.96226 18 3.70943 18 3.39623C18 3.08302 17.7488 2.83019 17.4375 2.83019Z" fill="#FF4848"/>
</svg>
''';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Dismissible(
      key: Key(cartItem.product.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cartProvider.removeFromCart(cartItem.product.id); // Remove item
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('${cartItem.product.title} removed from cart.')),
        );
      },
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE6E6),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            const Spacer(),
            SvgPicture.string(trashIcon),
          ],
        ),
      ),
      child: CartCard(cart: cartItem),
    );
  }
}

class CartCard extends StatelessWidget {
  final CartItem cart;

  const CartCard({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(cart.product.image),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          // Ensure text takes available space
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cart.product.title,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  text: "\$${cart.product.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Color(0xFFFF7643)),
                  children: [
                    TextSpan(
                        text: " x${cart.quantity}",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              const SizedBox(height: 8), // Added spacing
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (cart.quantity > 1) {
                          cartProvider.updateQuantity(
                              cart.product.id, cart.quantity - 1);
                        } else {
                          cartProvider.removeFromCart(cart.product.id);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${cart.quantity}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        cartProvider.updateQuantity(
                            cart.product.id, cart.quantity + 1);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
