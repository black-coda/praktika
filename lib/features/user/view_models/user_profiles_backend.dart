import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/authentication/controller/supabase_provider.dart';
import 'package:myapp/features/user/model/user_model.dart';
import 'package:myapp/utils/constant/constant.dart';

// class UserProfilesBackend {
//   final Ref ref;

//   UserModel? _userModel;

//   UserModel? get userModel => _userModel;

//   UserProfilesBackend(this.ref);
//   Future<Map<String, dynamic>> getUserDetails() async {
//     log("passing through getUserDetails");
//     final supabase = ref.watch(supabaseProvider);
//     final currentUserUID = supabase.auth.currentUser!.id;

//     final data = await supabase
//         .from(Constant.profileTable)
//         .select()
//         .eq("id", currentUserUID);

//     final jsonData = data.first;
//     //! get cached user data
//     _userModel = UserModel.fromJson(jsonData);
//     log(_userModel.toString(), name: "UserModel");
//     return jsonData;
//   }
// }

class UserProfilesBackend {
  // The single instance of the class
  static final UserProfilesBackend _instance = UserProfilesBackend._internal();

  // A factory constructor that returns the singleton instance
  factory UserProfilesBackend(Ref ref) {
    _instance.ref = ref;
    return _instance;
  }

  // The actual constructor, marked as private
  UserProfilesBackend._internal();

  late Ref ref; // Ref is late because it will be initialized by the factory

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  Future<Map<String, dynamic>> getUserDetails() async {
    log("passing through getUserDetails");
    final supabase = ref.watch(supabaseProvider);
    final currentUserUID = supabase.auth.currentUser!.id;

    final data = await supabase
        .from(Constant.profileTable)
        .select()
        .eq("id", currentUserUID);

    final jsonData = data.first;
    //! get cached user data
    _userModel = UserModel.fromJson(jsonData);
    log(_userModel.toString(), name: "UserModel");
    return jsonData;
  }
}
