// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/screens/dashboard_screen.dart';
import 'package:myapp/features/authentication/controller/is_logged_in_provider.dart';
import 'package:myapp/features/authentication/controller/supabase_provider.dart';
import 'package:myapp/features/authentication/model/auth_dto.dart';
import 'package:myapp/app/onboard/views/screen/onboard_entry_screen.dart';
import 'package:myapp/features/authentication/view/login_view.dart';
import 'package:myapp/features/authentication/view_models/authenticator.dart';
import 'package:myapp/utils/extension/extension.dart';
import 'package:myapp/utils/router/router_manager.dart';
import 'package:myapp/utils/toast/toast_manager.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_result.dart';

@immutable
class AuthState {
  final Session? session;
  final bool isLoading;
  final AuthResult? result;

  const AuthState({this.session, required this.isLoading, this.result});

  const AuthState.defaultState()
      : session = null,
        isLoading = false,
        result = null;

  AuthState copyWithForIsLoading({
    bool? isLoading,
    Session? session,
    AuthResult? result,
  }) {
    return AuthState(
      session: session ?? this.session,
      isLoading: isLoading ?? this.isLoading,
      result: result ?? this.result,
    );
  }
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(this.authenticator, this.ref)
      : super(
          const AuthState.defaultState(),
        ) {
    if (authenticator.isLoggedIn) {
      state = AuthState(
        isLoading: false,
        session: ref.read(supabaseProvider).auth.currentSession,
        result: AuthResult.signedIn,
      );
    }
  }
  final Ref ref;

  final Authenticator authenticator;

  void setIsLoading(bool isLoading) {
    state = state.copyWithForIsLoading(isLoading: isLoading);
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      setIsLoading(true);
      final responseSession = await authenticator.nativeGoogleSignIn();
      // Show success toast
      ToastManager().showToast(context, "Logged in successfully 🥰");
      state = AuthState(
          session: responseSession,
          isLoading: false,
          result: AuthResult.signedIn);
      Navigator.of(context).pushAnimated(const DashboardView());
    } on AuthException catch (e) {
      log(e.message);
      state = const AuthState(
        session: null,
        isLoading: false,
        result: AuthResult.error,
      );
    } catch (e) {
      log(e.toString());
      state = const AuthState(
        session: null,
        isLoading: false,
        result: AuthResult.error,
      );
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> loginWithEmailAndPassword(
      AuthDTO model, BuildContext context) async {
    // final navigate = Navigator.of(context);
    try {
      setIsLoading(true);
      final responseSession =
          await authenticator.loginWithEmailAndPassword(model);

      // Show success toast
      ToastManager().showToast(context, "Logged in successfully 🥰");
      state = AuthState(
          session: responseSession,
          isLoading: false,
          result: AuthResult.signedIn);
      log(state.session != null ? "Logged in" : "Not logged in");
    } on SocketException catch (e) {
      log(e.toString());
      state = const AuthState(
        session: null,
        isLoading: false,
        result: AuthResult.error,
      );
    } on AuthException catch (e) {
      log(e.message);
      // Show success toast
      ToastManager().showToast(context, e.message);
      state = const AuthState(
          session: null, isLoading: false, result: AuthResult.error);
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> registerWithEmailAndPassword(
      AuthDTO model, BuildContext context) async {
    final navigate = Navigator.of(context);
    try {
      setIsLoading(true);

      // Call the registration method
      await authenticator.registerWithEmailAndPassword(model);

      // Show success toast
      ToastManager().showToast(context, "Account created successfully 🥰");

      // Reset the state to default after successful registration
      state = const AuthState.defaultState();

      // Navigate to the LoginView and clear the navigation stack
      navigate.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginView()),
        (Route<dynamic> route) =>
            route.settings.name ==
            RouterManager.logoutRoute, // This clears the previous routes
      );
      log("Account created successfully");
    } on SocketException catch (e) {
      log(e.toString());
      ToastManager().showToast(context,
          "It seems like you are not connected to the internet.\nPlease check your connection and try again.");

      state = const AuthState(
        session: null,
        isLoading: false,
        result: AuthResult.error,
      );
    } on AuthException catch (e) {
      log(e.message, name: "Registration AuthException");
      ToastManager().showToast(context, e.message);

      state = const AuthState(
        session: null,
        isLoading: false,
        result: AuthResult.error,
      );
    } finally {
      // Ensure loading is stopped even after an error occurs
      setIsLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      setIsLoading(true);
      await authenticator.logout();
      state = const AuthState.defaultState();
    } on AuthException catch (e) {
      log(e.message);
    } finally {
      setIsLoading(false);
    }
  }

  void initialization(context) {
    final supabaseClient = ref.watch(supabaseProvider);
    supabaseClient.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;
      if (event == AuthChangeEvent.signedIn) {
        Navigator.of(context).pushAnimated(const DashboardView());
      }
      if (event == AuthChangeEvent.initialSession && session != null) {
        Navigator.of(context).pushAnimated(const DashboardView());
      }
      if (event == AuthChangeEvent.signedOut) {
        Navigator.of(context).pushAnimated(const OnboardEntryScreen());
      }
    });
  }
}
