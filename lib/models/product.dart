// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? image,
    String? description,
    String? category,
    Rating? rating,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
      category: category ?? this.category,
      rating: rating ?? this.rating,
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
      price: map['price'] as double,
      image: map['image'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      rating: Rating.fromMap(map['rating'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, title: $title, price: $price, image: $image, description: $description, category: $category, rating: $rating)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.price == price &&
        other.image == image &&
        other.description == description &&
        other.category == category &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        price.hashCode ^
        image.hashCode ^
        description.hashCode ^
        category.hashCode ^
        rating.hashCode;
  }
}
