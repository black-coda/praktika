import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/controllers/bottom_navbar_controller/btn_nav_controller.dart';
import 'package:myapp/features/authentication/controller/supabase_provider.dart';
import 'package:myapp/features/authentication/model/auth_dto.dart';
import 'package:myapp/key.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenticator {
  final Ref ref;

  bool get isLoggedIn => ref.read(supabaseProvider).auth.currentUser != null;

  Authenticator({required this.ref});

  Future<void> logout() async {
    try {
      await ref.read(supabaseProvider).auth.signOut();
    } on AuthException {
      rethrow;
    } finally {
      ref.read(indexProvider.notifier).update((index) => index = 0);
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

  Future<Session> nativeGoogleSignIn() async {
    final supabase = ref.read(supabaseProvider);

    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ["email"],
      clientId: HiddenKey.googleAuthToken,
    );
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw 'No Google User found.';
    }

    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    final session = await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    return session.session!;
  }
}
