import 'rating.dart';

class Product {
  final int id;
  final String title;
  final double price;
  final String image;
  final String description;
  final String category;
  final Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(), // Ensure price is parsed as double
      image: json['image'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      rating: Rating.fromJson(json['rating']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'description': description,
      'category': category,
      'rating': rating.toJson(),
    };
  }

  factory Product.empty() {
    return Product(
      id: -1,
      title: "Empty",
      price: 0.0,
      image: "",
      description: "This is a default description",
      category: "None",
      rating: Rating(rate: 0.0, count: 0),
    );
  }
}
