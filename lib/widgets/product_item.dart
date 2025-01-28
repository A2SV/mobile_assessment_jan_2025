import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {super.key, this.imageUrl, required this.title, required this.price});
  final imageUrl;
  final String title;
  final double price;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow
            blurRadius: 10,
            offset: const Offset(0, 4), // Shadow position
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(10), // Same border radius as container
        child: Column(
          children: [
            Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow:
                  TextOverflow.ellipsis, // Adding ellipsis for overflowed text
            ),
            const SizedBox(height: 5),
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
