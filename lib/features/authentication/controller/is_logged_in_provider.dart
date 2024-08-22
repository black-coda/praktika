import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_controller.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateNotifierProvider);
  return authState.session != null;
});