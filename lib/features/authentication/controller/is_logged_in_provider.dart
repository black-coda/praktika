import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_controller.dart';
import 'supabase_provider.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateNotifierProvider);
  final supabase = ref.watch(supabaseProvider);
  log(authState.session.toString(), name: "isLoggedInProvider");
  // TODO: Continue from here
  return authState.session != null || supabase.auth.currentUser != null;
});
