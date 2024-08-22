import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/features/authentication/controller/auth_controller.dart';
import 'package:myapp/features/authentication/controller/is_logged_in_provider.dart';
import 'package:myapp/features/authentication/view/login_view.dart';
import 'package:myapp/key.dart';
import 'package:myapp/app/onboard/views/screen/onboard_entry_screen.dart';
import 'package:myapp/utils/router/router_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/view/screens/dashboard_screen.dart';
import 'features/authentication/controller/is_loading_provider.dart';
import 'features/authentication/controller/supabase_provider.dart';
import 'features/authentication/view/auth_view.dart';
import 'features/authentication/view/logout_view.dart';
import 'utils/constant/constant.dart';
import 'utils/loader/loading_screen_widget.dart';

void main() async {
  await Supabase.initialize(
    url: HiddenKey.url,
    anonKey: HiddenKey.anonKey,
  );
  runApp(
    const ProviderScope(
      child: AppEntry(),
    ),
  );
}

class AppEntry extends ConsumerWidget {
  const AppEntry({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Constant.backgroundColorDark,
        textTheme: GoogleFonts.unboundedTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Constant.backgroundColorDark,
        ),
        useMaterial3: true,
      ),
      home: Consumer(
        builder: (context, ref, child) {
          ref.listen<bool>(
            authLoadingStateProvider,
            (previous, next) {
              if (next) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      LoadScreenWidget(isLoading: true, child: Container()),
                );
              } else {
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
          );

          return const App();
        },
      ),
      onGenerateRoute: MaterialRouteManager.generateRoute,
    );
  }
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  bool? _isFirstTime;

  @override
  void initState() {
    super.initState();
    _checkFirstTimeOpening();
  }

  Future<void> _checkFirstTimeOpening() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      // Mark the app as opened for the first time
      await prefs.setBool('isFirstTime', false);
    }

    setState(() {
      _isFirstTime = isFirstTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstTime == null) {
      // Still checking if it's the first time, show a loading indicator
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (_isFirstTime == true) {
      // Show onboarding or welcome screen if it's the first time
      return const OnboardEntryScreen();
    }
    final authStateAsyncValue = ref.watch(authStreamProvider);
    log(authStateAsyncValue.value?.event.toString() ?? "passing through main",
        name: "App Entry");

    return authStateAsyncValue.when(
      data: (authState) {
        if (authState.event == AuthChangeEvent.signedIn ||
            (authState.event == AuthChangeEvent.initialSession &&
                authState.session != null)) {
          return const DashboardView();
        } else {
          return const LogoutView();
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

class App2 extends ConsumerStatefulWidget {
  const App2({super.key});

  @override
  ConsumerState<App2> createState() => _App2State();
}

class _App2State extends ConsumerState<App2> {
  @override
  Widget build(BuildContext context) {
    final supabase = ref.watch(supabaseProvider);
    return StreamBuilder(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        final AuthChangeEvent event = snapshot.data!.event;
        final Session? session = snapshot.data!.session;
        log("$event \n $session", name: "App Entry Stream");
        if (event == AuthChangeEvent.signedIn || (session != null)) {
          return const DashboardView();
        }
        return const OnboardEntryScreen();
      },
    );
  }
}

class App3 extends ConsumerStatefulWidget {
  const App3({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _App3State();
}

class _App3State extends ConsumerState<App3> {
  @override
  void initState() {
    super.initState();
    ref.read(authStateNotifierProvider.notifier).initialization(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
