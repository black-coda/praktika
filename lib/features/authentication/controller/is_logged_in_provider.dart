import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/authentication/model/auth_result.dart';

import 'auth_controller.dart';
import 'supabase_provider.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateNotifierProvider);
  final supabase = ref.watch(supabaseProvider);
  // TODO: Continue from here
  return authState.session != null || supabase.auth.currentUser != null;
});

final isSignedInProvider = Provider<AuthResult?>((ref) {
  final authState = ref.watch(authStateNotifierProvider);
  log(authState.result.toString(), name: "AuthState from isSignedInProvider");
  return authState.result;
});
