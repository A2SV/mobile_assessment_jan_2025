class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rate': rate,
      'count': count,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      rate: double.parse(map['rate'].toString()),
      count: map['count'] as int,
    );
  }
}
