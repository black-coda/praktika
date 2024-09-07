import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/authentication/controller/supabase_provider.dart';
import 'package:myapp/features/authentication/model/auth_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
