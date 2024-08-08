import 'dart:convert';
import 'dart:developer';
import 'package:myapp/utils/extension/extension.dart';

class Video {
  final int id;
  final String title;
  final int price;
  final String videoCategory;
  final VideoType videoType;
  final Duration duration;

  Video({
    required this.id,
    required this.title,
    required this.price,
    required this.videoCategory,
    required this.videoType,
    required this.duration,
  });

 

  // Parse a HH:MM:SS string to a Duration

  factory Video.fromMap(Map<String, dynamic> map) {
    
    return Video(
      id: map['id'] as int,
      title: map['title'] as String,
      price: map['price'] as int,
      videoCategory:map['vid_category'] as String,
      videoType: VideoType.values.byName(map['vid_type']),
      duration: map["duration"].toString().durationFromString(),
    );
  }

  factory Video.fromJson(String source) =>
      Video.fromMap(json.decode(source) as Map<String, dynamic>);
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
