import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/authentication/controller/auth_controller.dart';
import 'package:myapp/authentication/controller/supabase_provider.dart';
import 'package:myapp/user/view_models/user_profiles_backend.dart';
import 'package:myapp/utils/constant/constant.dart';

class UserProfileView extends ConsumerStatefulWidget {
  const UserProfileView({super.key});

  @override
  ConsumerState<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends ConsumerState<UserProfileView> {
  @override
  void didChangeDependencies() async {
    //  await ref.read(userProfileBackendProvider).getUserDetails();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final userDetail =
    return Scaffold(
      appBar: AppBar(
        title: const Text("My profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              // TODO: implement notification
            },
            icon: const Icon(
              Icons.notification_important_outlined,
              color: Color(0xff6C6C6C),
            ),
          ),
        ],
      ),
      body: ref.read(userProfileBackendProvider).map(
            loading: (_) {
              return const Center(
                child: LinearProgressIndicator(),
              );
            },
            error: (error) => const Center(child: Text("Error")),
            data: (data) {
              log(data.toString());
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 16),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                              maxRadius: 15,
                              foregroundImage: NetworkImage(
                                  "https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671116.jpg?w=826&t=st=1717727695~exp=1717728295~hmac=ec1f2b2f76d8254081ea5a1a2bda88801ec3a11cef9f6282030b5ed61c983c19")),
                          const SizedBox(height: 8),
                          const Text(
                            "  userDetail[]",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton.icon(
                            onPressed: () async {
                              await ref
                                  .read(authStateNotifierProvider.notifier)
                                  .logout();
                            },
                            label: const Text("Logout"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}
