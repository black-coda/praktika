import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/model/category_model.dart';
import 'package:myapp/app/model/course_model.dart';

final fetchCoursesProvider = FutureProvider<List<CourseModel>>((ref) async {
  return Future.delayed(const Duration(seconds: 4), () {
    return [
      const CourseModel(
        title: "UI/UX Design",
        price: "199",
        rating: "4.5",
        category: CategoryModel.course,
      ),
      const CourseModel(
        title: "Advertising Manager",
        price: "1500",
        rating: "4.3",
        category: CategoryModel.course,
      ),
      const CourseModel(
        title: "Graphic Design",
        price: "1200",
        rating: "4.7",
        category: CategoryModel.course,
      ),
      const CourseModel(
        title: "Web Development",
        price: "1000",
        rating: "4.6",
        category: CategoryModel.course,
      ),
      const CourseModel(
        title: "Figma base",
        price: "300",
        rating: "4.8",
        category: CategoryModel.lecture,
      ),
      const CourseModel(
        title: "Adobe XD",
        price: "400",
        rating: "4.9",
        category: CategoryModel.lecture,
      ),
      const CourseModel(
        title: "Sketch",
        price: "500",
        rating: "4.7",
        category: CategoryModel.lecture,
      ),
      const CourseModel(
        title: "Communication Theory",
        price: "600",
        rating: "4.6",
        category: CategoryModel.lecture,
      ),
      const CourseModel(
        title: "Design Thinking",
        price: "700",
        rating: "4.5",
        category: CategoryModel.lecture,
      ),
      const CourseModel(
        title: "Illustrator full course",
        price: "199",
        rating: "4.5",
        category: CategoryModel.course,
      ),
    ];
  });
});
