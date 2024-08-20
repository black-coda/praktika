import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/authentication/controller/auth_controller.dart';

final authLoadingStateProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateNotifierProvider);
  return authState.isLoading;
});
