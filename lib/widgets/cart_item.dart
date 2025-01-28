import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/cart.dart';
import '../providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    
    return Dismissible(
      key: ValueKey(cartItem.product.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        margin: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 4.h,
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40.sp,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to remove this item from the cart?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        cartProvider.removeFromCart(cartItem.product.id);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${cartItem.product.title} removed from cart'),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () {
                cartProvider.addToCart(
                  cartItem.product,
                  quantity: cartItem.quantity,
                );
              },
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 4.h,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: cartItem.product.image,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              cartItem.product.title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                Text(
                  'Price: \$${cartItem.product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Total: \$${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: cartItem.quantity > 1 
                        ? Theme.of(context).primaryColor 
                        : Colors.grey,
                  ),
                  onPressed: cartItem.quantity > 1
                      ? () => cartProvider.updateQuantity(
                          cartItem.product.id, cartItem.quantity - 1)
                      : null,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    '${cartItem.quantity}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => cartProvider.updateQuantity(
                      cartItem.product.id, cartItem.quantity + 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
