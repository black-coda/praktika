// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:myapp/utils/extension/extension.dart';

class Video {
  final int id;
  final String title;
  final int price;
  final String videoCategory;
  final VideoType videoType;
  final Duration duration;
  final bool isFavorite;
  final String description;
  final String videoUrl;
  final String material_url;

  Video({
    required this.id,
    required this.title,
    required this.price,
    required this.videoCategory,
    required this.videoType,
    required this.duration,
    this.isFavorite = false,
    this.description = '',
    this.videoUrl = '',
    this.material_url = '',
  });

  // Parse a HH:MM:SS string to a Duration

  factory Video.fromMap(Map<String, dynamic> map) {
    // Safely handle 'my_learning' and 'is_favorite'
    final myLearning = map['my_learning'] as List<dynamic>?;
    final isFavorite = myLearning != null && myLearning.isNotEmpty
        ? myLearning.first['is_favorite'] as bool? ?? false
        : false;
 

    return Video(
      id: map['id'] as int,
      title: map['title'] as String,
      price: map['price'] as int,
      videoCategory: map['vid_category'] as String,
      videoType: VideoType.values.byName(map['vid_type']),
      duration: map["duration"].toString().durationFromString(),
      isFavorite: isFavorite,
      description: map['description'] as String,
      videoUrl: map['video_url'] as String,
    );
  }

  factory Video.fromJson(String source) =>
      Video.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Video other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      price.hashCode ^
      videoCategory.hashCode ^
      videoType.hashCode ^
      duration.hashCode ^
      description.hashCode ^
      isFavorite.hashCode;
  }

  @override
  String toString() {
    return 'Video(id: $id, title: $title, price: $price, videoCategory: $videoCategory, videoType: $videoType, duration: $duration, isFavorite: $isFavorite)';
  }
}

enum VideoType {
  lecture,
  course,
  all,
}

enum VideoStatus {
  completed,
  inProgress,
  notStarted,
}
