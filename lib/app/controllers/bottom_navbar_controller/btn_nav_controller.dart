import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/screens/dashboard_screen.dart';
import 'package:myapp/user/view/profile.dart';
import 'package:myapp/user/view_models/user_profiles_backend.dart';
import 'package:myapp/utils/error/view/error_view.dart';

final indexProvider = StateProvider<int>((ref) {
  return 0;
});

final navBarScreenProvider = Provider.family<Widget, int>((ref, index) {
  List<Widget> screens = [
    const DashboardEntryScreen(),
    Container(color: Colors.red),
    Container(color: Colors.blue),
    ErrorView(
      errorMessage: "User Profile Error",
      providerClass: userProfileBackendFutureProvider,
    ),
    const UserProfileView(),
  ];
  return screens[index];
});
