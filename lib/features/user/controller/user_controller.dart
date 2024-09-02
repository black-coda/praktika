import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/user_profiles_backend.dart';

final userDetailsProvider = Provider<UserProfilesBackend>((ref) {
  return UserProfilesBackend(ref);
});

final userProfileBackendFutureProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  return await UserProfilesBackend(ref).getUserDetails();
});
