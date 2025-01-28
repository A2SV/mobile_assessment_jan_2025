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

  factory Product.empty() {
    return Product(
      id: -1,
      title: "Empty",
      price: 0,
      image: "",
      description: "This is default description",
      category: "None",
      rating: Rating(rate: 0, count: 0),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'description': description,
      'category': category,
      'rating': rating.toMap(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      title: map['title'] as String,
      price: double.parse(map['price'].toString()),
      image: map['image'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      rating: Rating.fromMap(map['rating'] as Map<String, dynamic>),
    );
  }

  static listProvider(List<dynamic> data) =>
      data.map((e) => Product.fromMap(e)).toList();
}
