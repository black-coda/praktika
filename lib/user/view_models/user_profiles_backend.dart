import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/authentication/controller/supabase_provider.dart';
import 'package:myapp/utils/constant/constant.dart';

class UserProfilesBackend {
  final Ref ref;

  UserProfilesBackend(this.ref);
  Future<Map<String, dynamic>> getUserDetails() async {
    final supabase = ref.watch(supabaseProvider);
    final currentUserUID = supabase.auth.currentUser!.id;
    log(currentUserUID, name: "user profile uid");
    final data = await supabase
        .from(Constant.userTable)
        .select()
        .eq("user_uid", currentUserUID);
    log(data.toString(), name: "user profile uid");
    return data.first;
  }
}

final userProfileBackendFutureProvider = FutureProvider<Map<String,dynamic>>((ref) async {
  return await UserProfilesBackend(ref).getUserDetails();
});
