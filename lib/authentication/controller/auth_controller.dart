import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/authentication/model/auth_state.dart';

final authenticatorProvider = Provider<Authenticator>((ref) {
  return Authenticator(ref: ref);
});

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final authenticator = ref.watch(authenticatorProvider);
  return AuthStateNotifier(authenticator, ref);
});


final authLoadingStateProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateNotifierProvider);
  return authState.isLoading;
});