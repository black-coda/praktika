import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/user_profiles_backend.dart';

final userDetailsProvider = Provider<UserProfilesService>((ref) {
  return UserProfilesService(ref);
});

final userProfileBackendFutureProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  return await UserProfilesService(ref).getUserDetails();
});
