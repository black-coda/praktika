import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/authentication/controller/supabase_provider.dart';
import 'package:myapp/features/user/model/user_model.dart';
import 'package:myapp/utils/constant/constant.dart';

class UserProfilesBackend {
  final Ref ref;

  late UserModel _userModel;

  UserModel get userModel => _userModel;

  UserProfilesBackend(this.ref);
  Future<Map<String, dynamic>> getUserDetails() async {
    final supabase = ref.watch(supabaseProvider);
    final currentUserUID = supabase.auth.currentUser!.id;

    final data = await supabase
        .from(Constant.profileTable)
        .select()
        .eq("id", currentUserUID);

    final jsonData = data.first;
    //! get cached user data
    _userModel = UserModel.fromJson(jsonData);
    log(_userModel.fullName);
    return jsonData;
  }
}
