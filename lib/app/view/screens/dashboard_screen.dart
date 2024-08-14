import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/controllers/bottom_navbar_controller/btn_nav_controller.dart';
import 'package:myapp/app/view/widgets/bottom_nav_bar.dart';
import 'package:myapp/app/view/widgets/chip.dart';
import 'package:myapp/user/view_models/user_profiles_backend.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/loader/simmer_text.dart';
import 'package:myapp/utils/router/router_manager.dart';
import 'package:myapp/video/controller/videos_controller.dart';

import '../widgets/header.dart';
import '../widgets/video_card.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  Widget build(BuildContext context) {
    final index = ref.watch(indexProvider);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        child: Container(
          height: 64,
          decoration: const BoxDecoration(
            color: Color(0xff2F2F2F),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Material(
            elevation: 0.0,
            color: const Color(0xff2F2F2F),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: const BottomNavBar(),
          ),
        ),
      ),
      body: ref.watch(navBarScreenProvider(index)),
    );
  }
}

class DashboardEntryScreen extends ConsumerWidget {
  const DashboardEntryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videos = ref.watch(videosFutureProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: CustomScrollView(
          slivers: [
            //? Appbar
            SliverAppBar(
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RouterManager.userProfileRoute);
                },
                child: const CircleAvatar(
                    maxRadius: 15,
                    foregroundImage:
                        NetworkImage(Constant.defaultProfileImage)),
              ),
              title: Consumer(
                builder: (context, ref, child) {
                  final userDetails =
                      ref.watch(userProfileBackendFutureProvider);
                  return userDetails.when(
                    data: (data) {
                      return Text("Hello, ${data['username']}",
                          style: Constant.appBarTitleStyle(context));
                    },
                    loading: () {
                      return const ShimmerText("Loading...",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400));
                    },
                    error: (_, __) {
                      return const Text(
                        "Error fetching user data",
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  );
                },
              ),
              actions: const [
                Icon(
                  Icons.notification_important_outlined,
                  color: Color(0xff6C6C6C),
                )
              ],
            ),
            //? category filter
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Wrap(
                  spacing: 4.0,
                  runSpacing: 0.0,
                  children: [
                    ...[
                      "UI/UX",
                      "Illustrations",
                      "Graphic design",
                      "Marketing",
                      "Business",
                      "Web development",
                      "Mobile development",
                    ].map(
                      (category) => ChipWidget(
                        text: category,
                        isSelected:
                            ref.watch(categoryStateProvider.notifier).state ==
                                category,
                        onTap: () {
                          isCategoryFilterSelected(ref, category);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //? videos after loading
            videos.when(
              data: (courses) {
                return SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeaderWidget("Courses"),
                      VideoCard(
                        videosList: ref.watch(courseVideoProvider(categoryFilterProvider)),
                      ),
                      SpacerConstant.sizedBox20,
                      const HeaderWidget("Lectures"),
                      VideoCard(
                        videosList: ref.watch(lectureVideoProvider(categoryFilterProvider)),
                      ),
                    ],
                  ),
                );
              },
              error: (e, __) {
                log(e.toString(), name: "Error fetching videos");
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Error  🤔",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.error),
                        ),
                      ),
                      SpacerConstant.sizedBox40,
                      ElevatedButton(
                        onPressed: () {
                          ref.invalidate(videosFutureProvider);
                        },
                        child: const Text("Retry"),
                      )
                    ],
                  ),
                );
              },
              loading: () => const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void isCategoryFilterSelected(WidgetRef ref, String category) {
    final categoryNotifier = ref.watch(categoryStateProvider.notifier);

    if (categoryNotifier.state == category) {
      categoryNotifier.state = null;
    } else {
      categoryNotifier.state = category;
    }
  }
}
