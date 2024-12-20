import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/controllers/bottom_navbar_controller/btn_nav_controller.dart';
import 'package:myapp/app/view/widgets/bottom_nav_bar.dart';
import 'package:myapp/app/view/widgets/chip.dart';
import 'package:myapp/features/notification/view/screens/notification_screen.dart';
import 'package:myapp/features/user/controller/user_controller.dart';
import 'package:myapp/features/user/view/profile_view.dart';
import 'package:myapp/features/user/view_models/user_profiles_backend.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/extension/extension.dart';
import 'package:myapp/utils/loader/simmer_text.dart';
import 'package:myapp/utils/router/router_manager.dart';
import 'package:myapp/features/video/controller/videos_controller.dart';
import 'package:myapp/utils/shared/no_internet_screen.dart';

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
    final navbarCurrentIndex = ref.watch(indexProvider);
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const BottomNavBar(),
      body: ref.watch(navBarScreenProvider(navbarCurrentIndex)),
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
      child: CustomScrollView(
        slivers: [
          //? AppBar
          SliverAppBar(
            leading: GestureDetector(
              onTap: () {
                context.push(const UserProfileView());
              },
              child: const CircleAvatar(
                  maxRadius: 15,
                  foregroundImage: NetworkImage(Constant.defaultProfileImage)),
            ),
            title: Consumer(
              builder: (context, ref, child) {
                final userDetails = ref.watch(userProfileBackendFutureProvider);
                return userDetails.when(
                  data: (data) {
                    return Text(
                      "Hello, ${data['username']}",
                      style: Constant.appBarTitleStyle(context),
                    );
                  },
                  loading: () {
                    return const ShimmerText(
                      "Loading...",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    );
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
            actions: [
              IconButton(
                onPressed: () {
                  context.push(const NotificationScreen());
                },
                icon: Badge.count(
                  count: 2,
                  child: const Icon(
                    Icons.notifications,
                    color: Color(0xff6C6C6C),
                  ),
                ),
                padding: EdgeInsets.zero,
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
                      videosList: ref
                          .watch(courseVideoProvider(categoryFilterProvider)),
                    ),
                    SpacerConstant.sizedBox20,
                    const HeaderWidget("Lectures"),
                    VideoCard(
                      videosList: ref
                          .watch(lectureVideoProvider(categoryFilterProvider)),
                    ),
                    SpacerConstant.sizedBox20,
                    const HeaderWidget("Top"),
                    VideoCard(
                      videosList: ref
                          .watch(lectureVideoProvider(categoryFilterProvider))
                          .reversed
                          .toList(),
                    ),
                    const SizedBox(height: 100),
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
            loading: () => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ],
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
