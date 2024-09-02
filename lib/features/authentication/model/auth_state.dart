import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/screens/dashboard_screen.dart';

import 'package:myapp/features/authentication/controller/supabase_provider.dart';
import 'package:myapp/features/authentication/model/auth_dto.dart';
import 'package:myapp/app/onboard/views/screen/onboard_entry_screen.dart';
import 'package:myapp/utils/extension/extension.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_result.dart';

class AuthState {
  final Session? session;
  final bool isLoading;
  final AuthResult? result;

  AuthState({this.session, required this.isLoading, this.result});

  AuthState.defaultState()
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

class Authenticator {
  final Ref ref;

  Authenticator({required this.ref});

  Future<void> logout() async {
    try {
      final supabaseClient = ref.read(supabaseProvider);
      await supabaseClient.auth.signOut();
    } on AuthException {
      rethrow;
    }
  }

  Future<Session> loginWithEmailAndPassword(AuthDTO model) async {
    try {
      final supabaseClient = ref.read(supabaseProvider);
      final response = await supabaseClient.auth.signInWithPassword(
        email: model.email,
        password: model.password,
      );
      return response.session!;
    } on AuthException {
      rethrow;
    }
  }

  Future<void> registerWithEmailAndPassword(AuthDTO model) async {
    try {
      final supabaseClient = ref.read(supabaseProvider);
      log(model.username!);
      log(model.fullName!);
      await supabaseClient.auth.signUp(
        email: model.email,
        password: model.password,
        data: {
          'username': model.username,
          "full_name": model.fullName,
          "avatar_url": '',
        },
      );
    } on AuthException {
      rethrow;
    }
  }
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(this.authenticator, this.ref)
      : super(AuthState.defaultState());
  final Ref ref;

  final Authenticator authenticator;

  void setIsLoading(bool isLoading) {
    state = state.copyWithForIsLoading(isLoading: isLoading);
  }

  Future<void> loginWithEmailAndPassword(AuthDTO model) async {
    try {
      setIsLoading(true);
      final responseSession =
          await authenticator.loginWithEmailAndPassword(model);
      state = AuthState(
          session: responseSession,
          isLoading: false,
          result: Success(msg: "login successful 🥰"));
      log(state.session != null ? "Logged in" : "Not logged in");
    } on SocketException catch (e) {
      log(e.toString());
      state = AuthState(
          session: null, isLoading: false, result: Error(msg: e.message));
    } on AuthException catch (e) {
      log(e.message);
      state = AuthState(
          session: null, isLoading: false, result: Error(msg: e.message));
    } finally {
      setIsLoading(false);
    }
  }

  Future<AuthResult> registerWithEmailAndPassword(AuthDTO model) async {
    try {
      setIsLoading(true);
      await authenticator.registerWithEmailAndPassword(model);
      // await ref.watch(supabaseProvider).from(Constant.userTable).insert({
      //   "email": model.email,
      //   "username": model.username,
      // });
      return Success(msg: "account created successful 🥰");
    } on AuthException catch (e) {
      log(e.message, name: "Registration AuthException");
      return Error(msg: e.message);
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      setIsLoading(true);
      await authenticator.logout();
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
        Navigator.of(context).animateTo(const DashboardView());
      }
      if (event == AuthChangeEvent.initialSession && session != null) {
        Navigator.of(context).animateTo(const DashboardView());
      }
      if (event == AuthChangeEvent.signedOut) {
        Navigator.of(context).animateTo(const OnboardEntryScreen());
      }
    });
  }
}
