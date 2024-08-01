import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/authentication/controller/auth_controller.dart';
import 'package:myapp/authentication/controller/supabase_provider.dart';
import 'package:myapp/user/view_models/user_profiles_backend.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/error/view/error_view.dart';

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
    final userProfile = ref.watch(userProfileBackendFutureProvider);
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
      body: switch (userProfile) {
        AsyncData(:final value) => SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: Constant.scaffoldPadding,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                          maxRadius: 60,
                          foregroundImage: NetworkImage(
                              "https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671116.jpg?w=826&t=st=1717727695~exp=1717728295~hmac=ec1f2b2f76d8254081ea5a1a2bda88801ec3a11cef9f6282030b5ed61c983c19")),
                      const SizedBox(height: 16),
                      Text(
                        value['username'].toString().toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      //* subscription card
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: const BoxDecoration(
                          color: Color(0xffF5F378),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      //* edit profile
                      //* settings
                      //* support
                      //* about app
                      TextButton.icon(
                        onPressed: () async {
                          await ref
                              .read(authStateNotifierProvider.notifier)
                              .logout();
                        },
                        label: const Text(
                          "Logout",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.solid,
                              decorationColor: Color(0xff6C6C6C),
                              color: Color(0xff6C6C6C)),
                        ),
                        icon:
                            const Icon(Icons.logout, color: Color(0xff6C6C6C)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        AsyncError(:final error) => ErrorView(
            errorMessage: error.toString(),
            providerClass: userProfileBackendFutureProvider,
          ),
        _ => const Center(
            child: Column(
              children: [
                Text('Loading...'),
                SizedBox(height: 16),
                LinearProgressIndicator(),
              ],
            ),
          ),
      },
    );
  }
}
