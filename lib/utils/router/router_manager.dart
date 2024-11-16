import 'package:flutter/material.dart';
import 'package:myapp/app/view/screens/dashboard_screen.dart';
import 'package:myapp/features/authentication/view/auth_view.dart';
import 'package:myapp/features/authentication/view/login_view.dart';
import 'package:myapp/features/authentication/view/session_mgmt_view.dart';
import 'package:myapp/features/authentication/view/register_view.dart';
import 'package:myapp/features/user/view/profile_view.dart';
import 'package:myapp/features/video/view/courses_view.dart';
import 'package:myapp/features/video/view/search_filter_view.dart';

class RouterManager {
  static const String authView = 'auth';
  static const String authRoute = '/auth';
  static const String loginView = 'login';
  static const String loginRoute = '/login';
  static const String homeView = 'home';
  static const String homeRoute = '/home';
  static const String onboardView = 'onboard';
  static const String onboardRoute = '/onboard';
  static const String registerView = 'register';
  static const String registerRoute = '/register';
  static const String userProfileView = 'userProfile';
  static const String userProfileRoute = '/userProfile';
  static const String courseDetailView = 'courseDetail';
  static const String courseDetailRoute = '/courseDetail';
  static const String searchFilterView = 'searchFilter';
  static const String searchFilterRoute = '/searchFilter';
  static const String jobListView = 'jobList';
  static const String jobListRoute = '/jobList';
  static const String logoutView = 'logout';
  static const String logoutRoute = '/logout';
}

class MaterialRouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterManager.authRoute:
        return MaterialPageRoute(
          builder: (context) => const AuthView(),
        );
      case RouterManager.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );
      case RouterManager.registerRoute:
        return MaterialPageRoute(
          builder: (context) => const RegisterView(),
        );
      case RouterManager.homeRoute:
        return MaterialPageRoute(
          builder: (context) => const DashboardView(),
        );
      case RouterManager.onboardRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );
      case RouterManager.userProfileRoute:
        return MaterialPageRoute(
          builder: (context) => const UserProfileView(),
        );
      case RouterManager.courseDetailRoute:
        return MaterialPageRoute(
          builder: (context) => const CourseDetailView(),
        );
      case RouterManager.searchFilterRoute:
        return MaterialPageRoute(
          builder: (context) => const SearchFilterView(),
        );
      case RouterManager.logoutView:
        return MaterialPageRoute(
          builder: (context) => const SessionManagementView(),
        );

      default:
        throw const FormatException();
    }
  }
}
