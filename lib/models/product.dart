import 'rating.dart';

class Product {
  final int id;
  final String title;
  final double price;
  final String image;
  final String description;
  final String category;
  final Rating rating;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
    required this.rating,
    this.isFavorite = false,
  });

  factory Product.empty() {
    return Product(
        id: -1,
        title: "Empty",
        price: 0,
        image: "",
        description: "This is default description",
        category: "None",
        rating: Rating(rate: 0, count: 0),
        isFavorite: false);
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
      description: json['description'],
      category: json['category'],
      rating: Rating.fromJson(json['rating']),
    );
  }
}
