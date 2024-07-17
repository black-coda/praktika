// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/authentication/controller/supabse_provider.dart';
import 'package:myapp/authentication/model/auth_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum AuthResult {
  success,
  error,
  aborted,
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

  Future<void> loginWithEmailAndPassword(AuthDTO model) async {
    try {
      final supabaseClient = ref.read(supabaseProvider);
      await supabaseClient.auth.signUp(
        email: model.email,
        password: model.password,
        data: {'username': model.username},
      );
    } on AuthException {
      rethrow;
    }
  }
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(this.authenticator) : super(AuthState.defaultState());

  final Authenticator authenticator;

  void setIsLoading(bool isLoading) {
    state = state.copyWithForIsLoading(isLoading: isLoading);
  }

  Future<AuthResult> loginWithEmailAndPassword(AuthDTO model) async {
    try {
      setIsLoading(true);
      await authenticator.loginWithEmailAndPassword(model);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.error;
    } finally {
      setIsLoading(false);
    }
  }
}
