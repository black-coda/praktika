import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/authentication/controller/auth_controller.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final isLoading = ref.watch(authStateNotifierProvider).isLoading;
  return isLoading;
});
