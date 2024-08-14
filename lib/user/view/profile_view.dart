import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/authentication/controller/auth_controller.dart';
import 'package:myapp/user/view_models/user_profiles_backend.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/error/view/error_view.dart';
import 'package:myapp/utils/loader/simmer_text.dart';
import 'package:myapp/utils/widget/custom_tile_widget.dart';

class UserProfileView extends ConsumerStatefulWidget {
  const UserProfileView({super.key});

  @override
  ConsumerState<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends ConsumerState<UserProfileView> {
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
                          foregroundImage:
                              NetworkImage(Constant.defaultProfileImage)),
                      const SizedBox(height: 16),
                      Text(
                        value['full_name'].toString().toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      SpacerConstant.sizedBox24,
                      //* subscription card
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: const BoxDecoration(
                          color: Color(0xffF5F378),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Your subscription\n is active until\n 12/01/2024",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff171717),
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text("Edit"),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: Image.asset(
                                "assets/sub.png",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SpacerConstant.sizedBox8,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            //* Edit profile
                            CustomTile(
                              title: "Edit Profile",
                              onTap: () {
                                // TODO: configure functionality
                              },
                            ),
                            //* Settings
                            CustomTile(
                              title: "Settings",
                              onTap: () {
                                // TODO: configure functionality
                              },
                            ),
                            //* Support
                            CustomTile(
                              title: "Support",
                              onTap: () {
                                // TODO: configure functionality
                              },
                            ),
                            //* About app
                            CustomTile(
                              title: "About App",
                              onTap: () {
                                // TODO: configure functionality
                              },
                            ),
                          ],
                        ),
                      ),

                      TextButton.icon(
                        onPressed: () async {
                          await ref
                              .read(authStateNotifierProvider.notifier)
                              .logout();
                        },
                        label: Text("Logout",
                            style: Constant.underlineStyle(context)),
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
            child: ShimmerText('Loading...'),
          ),
      },
    );
  }
}
