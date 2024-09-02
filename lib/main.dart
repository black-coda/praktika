import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/features/authentication/controller/auth_controller.dart';
import 'package:myapp/key.dart';
import 'package:myapp/app/onboard/views/screen/onboard_entry_screen.dart';
import 'package:myapp/utils/router/router_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/view/screens/dashboard_screen.dart';
import 'features/authentication/controller/is_loading_provider.dart';
import 'features/authentication/controller/is_logged_in_provider.dart';
import 'features/authentication/controller/supabase_provider.dart';
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
          
          
          //* display loading screen when isLoading is true
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

          return const App3();
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
//? Check for internet connection
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    ref.read(authStreamProvider);
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    _checkFirstTimeOpening();
    ref.read(isLoggedInProvider);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }

  //? check for first time installation
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

  //? verifying network request
  Future<bool> hasInternetConnection() async {
    try {
      final dio = Dio();
      final result = await dio.get(Constant.googleUrl);
      if (result.statusCode == 200) {
        return true; // Connected to the internet
      }
    } catch (e) {
      return false; // No internet connection
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionStatus.contains(ConnectivityResult.none)) {
      return const Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(
                "No Internet Connection",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      );
    }

    if (hasInternetConnection() == false) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No Internet Connection",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      );
    }

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
        if (authState.event == AuthChangeEvent.signedIn) {
          return const DashboardView();
        }
        if (authState.event == AuthChangeEvent.initialSession &&
            authState.session != null) {
          log((authState.session == null).toString(), name: "App Entry");
          return const DashboardView();
        }
        return const LogoutView();
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

class App3 extends ConsumerStatefulWidget {
  const App3({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _App3State();
}

class _App3State extends ConsumerState<App3> {
  bool? _isFirstTime;
//? Check for internet connection
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    ref.read(authStreamProvider);
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    _checkFirstTimeOpening();
    ref.read(isLoggedInProvider);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }

  //? check for first time installation
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

  //? verifying network request
  Future<bool> hasInternetConnection() async {
    try {
      final dio = Dio();
      final result = await dio.get(Constant.googleUrl);
      if (result.statusCode == 200) {
        return true; // Connected to the internet
      }
    } catch (e) {
      return false; // No internet connection
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionStatus.contains(ConnectivityResult.none)) {
      return const Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(
                "No Internet Connection",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      );
    }

    if (hasInternetConnection() == false) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No Internet Connection",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      );
    }

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

    final isLoggedInState = ref.watch(isLoggedInProvider);
    log(isLoggedInState.toString(), name: "Check for login state");
    return isLoggedInState ? const DashboardView() : const LogoutView();
  }
}
