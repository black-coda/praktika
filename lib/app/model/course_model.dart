import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/app/model/category_model.dart';

part 'course_model.freezed.dart';
part 'course_model.g.dart';

@freezed
class CourseModel with _$CourseModel {
   const factory CourseModel(
    {required String title,
    required String price,
    required String rating,
    required CategoryModel category,
    }
   ) = _CourseModel;
   factory CourseModel.fromJson(Map<String, dynamic> json) => _$CourseModelFromJson(json);
}