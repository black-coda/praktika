import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
}
