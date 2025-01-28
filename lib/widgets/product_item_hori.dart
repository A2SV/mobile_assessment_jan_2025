import 'package:flutter/material.dart';

class ProductItemHori extends StatelessWidget {
  const ProductItemHori(
      {super.key,
      this.imageUrl,
      required this.title,
      required this.price,
      this.onTap});

  final imageUrl;
  final String title;
  final double price;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title.split(' ').first, // Show only the text before the first space
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
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
    );
  }
}
