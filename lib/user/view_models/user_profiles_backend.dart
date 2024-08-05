import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/authentication/controller/supabase_provider.dart';
import 'package:myapp/authentication/model/auth_dto.dart';
import 'package:myapp/user/model/user_model.dart';
import 'package:myapp/utils/constant/constant.dart';

class UserProfilesBackend {
  final Ref ref;

  UserModel? _userModel;

  UserProfilesBackend(this.ref);
  Future<Map<String, dynamic>> getUserDetails() async {
    final supabase = ref.watch(supabaseProvider);
    final currentUserUID = supabase.auth.currentUser!.id;
    log(currentUserUID, name: "user profile uid");
    final data = await supabase
        .from(Constant.profileTable)
        .select()
        .eq("id", currentUserUID);
    log(data.toString(), name: "user profile uid");
    final jsonData = data.first;
    //! get cached user data
    _userModel = UserModel.fromJson(jsonData);
    return jsonData;
  }
}

final userDetailsProvider = Provider<UserProfilesBackend>((ref) {
  return UserProfilesBackend(ref);
});

final userProfileBackendFutureProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {
  return await UserProfilesBackend(ref).getUserDetails();
});
