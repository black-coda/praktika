import 'dart:convert';

class Review {
  final int id;
  final String review;
  final int rating;
  final int videoID;

  Review({
    required this.id,
    required this.review,
    required this.rating,
    required this.videoID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'review': review,
      'rating': rating,
      'videoID': videoID,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as int,
      review: map['review'] as String,
      rating: map['rating'] as int,
      videoID: map['videoID'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source) as Map<String, dynamic>);
}
