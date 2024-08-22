import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/app/view/screens/dashboard_screen.dart';
import 'package:myapp/features/authentication/view/login_view.dart';
import 'package:myapp/features/authentication/view/register_view.dart';
import 'package:myapp/features/user/view/profile_view.dart';
import 'package:myapp/features/video/view/courses_view.dart';
import 'package:myapp/features/video/view/search_filter_view.dart';

final routerManagerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      routes: [
        GoRoute(
          path: RouterManager.loginRoute,
          name: RouterManager.loginView,
        ),
        GoRoute(
          path: RouterManager.homeRoute,
          name: RouterManager.homeView,
        ),
        GoRoute(
          path: RouterManager.onboardRoute,
          name: RouterManager.onboardView,
        ),
      ],
    );
  },
);

class RouterManager {
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
}

class MaterialRouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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

      default:
        throw const FormatException();
    }
  }
}
