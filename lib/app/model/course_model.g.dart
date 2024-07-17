// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseModelImpl _$$CourseModelImplFromJson(Map<String, dynamic> json) =>
    _$CourseModelImpl(
      title: json['title'] as String,
      price: json['price'] as String,
      rating: json['rating'] as String,
      category: $enumDecode(_$CategoryModelEnumMap, json['category']),
    );

Map<String, dynamic> _$$CourseModelImplToJson(_$CourseModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'price': instance.price,
      'rating': instance.rating,
      'category': _$CategoryModelEnumMap[instance.category]!,
    };

const _$CategoryModelEnumMap = {
  CategoryModel.course: 'course',
  CategoryModel.lecture: 'lecture',
};
