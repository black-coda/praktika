import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/screens/dashboard_screen.dart';
import 'package:myapp/features/jobs/view/screens/jobs_view.dart';
import 'package:myapp/features/user/view/profile_view.dart';
import 'package:myapp/features/video/view/my_learning_view.dart';
import 'package:myapp/features/video/view/search_view.dart';

final indexProvider = StateProvider<int>((ref) {
  return 0;
});

final navBarScreenProvider = Provider.family<Widget, int>((ref, index) {
  List<Widget> screens = [
    const DashboardEntryScreen(),
    const SearchView(),
    const MyLearningView(),
    const CareerView(),
    const UserProfileView(),
  ];
  return screens[index];
});
