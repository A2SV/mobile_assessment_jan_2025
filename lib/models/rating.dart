// class Rating {
//   final double rate;
//   final int count;

//   Rating({required this.rate, required this.count});
// }

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  // Add fromJson factory
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'] as int,
    );
  }
}
