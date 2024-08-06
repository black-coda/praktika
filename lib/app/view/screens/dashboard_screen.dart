import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/controllers/bottom_navbar_controller/btn_nav_controller.dart';
import 'package:myapp/app/controllers/fetch_courses_controller.dart';
import 'package:myapp/app/model/course_model.dart';
import 'package:myapp/app/view/widgets/bottom_nav_bar.dart';
import 'package:myapp/app/view/widgets/chip.dart';
import 'package:myapp/user/view_models/user_profiles_backend.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/loader/simmer_text.dart';
import 'package:myapp/utils/router/router_manager.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
 

 @override
  void initState() {
    super.initState();
    ref.read(userDetailsProvider).getUserDetails();
  }

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
    final courseModel = ref.watch(fetchCoursesProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: CustomScrollView(
          slivers: [
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
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: const Color(0xffDCC1FF),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400));
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
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Wrap(
                  spacing: 4.0,
                  runSpacing: 0.0,
                  children: [
                    ChipWidget(text: "UI/UX"),
                    ChipWidget(text: "Illustrations"),
                    ChipWidget(text: "Graphic Design"),
                    ChipWidget(text: "Marketing"),
                    ChipWidget(text: "Business"),
                    ChipWidget(text: "Web development"),
                    ChipWidget(text: "Mobile development"),
                  ],
                ),
              ),
            ),
            courseModel.when(
              data: (courses) {
                return SliverToBoxAdapter(
                  child: ItemCard(courseModel: courses),
                );
              },
              error: (_, __) {
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const Center(
                        child: Text("Error 🤔"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ref.invalidate(fetchCoursesProvider);
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
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.courseModel,
  });

  final List<CourseModel> courseModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: (index % 3 == 0)
                    ? const Color(0xffEC704B)
                    : (index % 3 == 1)
                        ? const Color(0xffF5F378)
                        : const Color(0xffDCC1FF),
              ),
              padding: const EdgeInsets.all(8),
              width: 250,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          courseModel[index].title,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                color: const Color(0xff242424),
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                        ),
                      ),
                      const Icon(Icons.favorite_border_outlined, size: 20)
                    ],
                  ),

                  Positioned(
                    bottom: 50,
                    left: 0,
                    child: Text(
                      "${courseModel[index].price} \$",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: const Color(0xff242424),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                    ),
                  ),

                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 60,
                            child: ChipElevatedBtn(
                                index: index,
                                ratings: courseModel[index].rating),
                          ),
                          const SizedBox(width: 4),
                        ],
                      )),

                  // price, tags,
                  Align(
                    alignment: Alignment.bottomRight,
                    widthFactor: 0,
                    child: SizedBox(
                      height: 100,
                      child: Image.asset(
                        "assets/img_2.png",
                        width: 150,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: courseModel.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class ChipElevatedBtn extends StatelessWidget {
  const ChipElevatedBtn(
      {super.key, required this.index, required this.ratings});

  final int index;
  final String ratings;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.star_border_outlined,
          size: 16,
          color: (index % 3 == 0)
              ? const Color(0xffEC704B)
              : (index % 3 == 1)
                  ? const Color(0xffF5F378)
                  : const Color(0xffDCC1FF)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff2F2F2F),
        // backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      label: Text(ratings,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
              color: (index % 3 == 0)
                  ? const Color(0xffEC704B)
                  : (index % 3 == 1)
                      ? const Color(0xffF5F378)
                      : const Color(0xffDCC1FF))),
    );
  }
}
