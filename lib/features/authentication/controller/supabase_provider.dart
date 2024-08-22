import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final authStreamProvider = StreamProvider<AuthState>((ref) async* {
  final client = ref.watch(supabaseProvider);
  yield* client.auth.onAuthStateChange.map((event) {
    return event;
  });
});
