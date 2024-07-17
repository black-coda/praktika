import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/screens/dashboard_screen.dart';
import 'package:myapp/authentication/view/login_view.dart';
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

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateAsyncValue = ref.watch(authStreamProvider);

    return authStateAsyncValue.when(
      data: (authState) {
        if (authState.event == AuthChangeEvent.signedIn ||
            (authState.event == AuthChangeEvent.initialSession &&
                authState.session != null)) {
          return const DashboardScreen();
        } else {
          return const LoginView();
        }
      },
      error: (error, stackTrace) {
        return Scaffold(
          body: Center(
            child: Text(
              error.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        );
      },
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
