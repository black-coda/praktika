import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/authentication/controller/supabase_provider.dart';
import 'package:myapp/authentication/model/auth_dto.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

sealed class AuthResult {}

class Success implements AuthResult {
  final String msg;

  Success({required this.msg});
}

class Error implements AuthResult {
  final String msg;

  Error({required this.msg});
}

class AuthState {
  final Session? session;
  final bool isLoading;

  AuthState({this.session, required this.isLoading});

  AuthState.defaultState()
      : session = null,
        isLoading = false;

  AuthState copyWithForIsLoading({
    bool? isLoading,
    Session? session,
  }) {
    return AuthState(
      session: session ?? this.session,
      isLoading: isLoading ?? this.isLoading,
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

  Future<void> loginWithEmailAndPassword(AuthDTO model) async {
    try {
      final supabaseClient = ref.read(supabaseProvider);
      await supabaseClient.auth.signInWithPassword(
        email: model.email,
        password: model.password,
      );
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

  Future<AuthResult> loginWithEmailAndPassword(AuthDTO model) async {
    try {
      setIsLoading(true);
      await authenticator.loginWithEmailAndPassword(model);
      return Success(msg: "login successful 🥰");
    } on SocketException catch (e) {
      log(e.toString());
      return Error(msg: "No internet available 🤌");
    } on AuthException catch (e) {
      log(e.message);
      return Error(msg: e.message);
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
      return Error(msg: "${e.statusCode}: ${e.message}");
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
}
