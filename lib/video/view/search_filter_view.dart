import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myapp/app/view/widgets/chip.dart';
import 'package:myapp/app/view/widgets/header.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/video/controller/search_and_filter_controllers.dart';
import 'package:myapp/video/model/video_model.dart';

class SearchFilterView1 extends ConsumerStatefulWidget {
  const SearchFilterView1({super.key});

  @override
  ConsumerState<SearchFilterView1> createState() => _SearchFilterViewState();
}

class _SearchFilterViewState extends ConsumerState<SearchFilterView1>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animation = Tween<double>(begin: 0, end: 0.5).animate(_animationController)
      ..addListener(() {
        log(_animationController.value.toString(), name: "animation value");
      });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(0, _animation.value * 100),
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.5,
            width: MediaQuery.sizeOf(context).width,
            color: Colors.white,
            child: const Scaffold(
              backgroundColor: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class SearchFilterView extends ConsumerWidget {
  const SearchFilterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Search Filters",
          style: Constant.appBarTitleStyle(context, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: Constant.scaffoldPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderWidget("Type"),
            SpacerConstant.sizedBox8,
            Wrap(
              spacing: 8,
              children: [
                ChipWidget(
                  text: "Lectures",
                  onTap: () {
                    log("Lectures tapped", name: "Lectures");
                    ref.read(filterVideoProvider.notifier).state =
                        VideoType.lecture;
                  },
                ),
                ChipWidget(
                  text: "Courses",
                  onTap: () {
                    log("Courses tapped", name: "Courses");
                    ref.read(filterVideoProvider.notifier).state =
                        VideoType.course;
                  },
                ),
              ],
            ),
            SpacerConstant.sizedBox24,
            const HeaderWidget("Categories"),
            SpacerConstant.sizedBox8,
            Wrap(
              spacing: 8,
              children: [
                ...[
                  "UI/UX",
                  "Illustrations",
                  "Graphic design",
                  "Marketing",
                  "Business"
                ].map((categoryName) => ChipWidget(text: categoryName)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
