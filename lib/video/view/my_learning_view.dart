import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/widgets/header.dart';
import 'package:myapp/app/view/widgets/video_card.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/video/controller/videos_controller.dart';

class MyLearning extends ConsumerWidget {
  const MyLearning({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final video = ref.watch(favoriteVideosProvider);
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          centerTitle: true,
          title: Text(
            'My Favorites',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: Constant.scaffoldPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderWidget("Courses"),
                VideoCard(
                  videosList:
                      ref.watch(courseVideoProvider(favoriteVideosProvider)),
                ),
                SpacerConstant.sizedBox20,
                const HeaderWidget("Lectures"),
                VideoCard(
                  videosList:
                      ref.watch(lectureVideoProvider(favoriteVideosProvider)),
                ),
                const SizedBox(height: 12),
                const Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: Constant.scaffoldPadding,
          sliver: SliverList.separated(
            itemCount: video.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 12);
            },
            itemBuilder: (BuildContext context, int index) {
              return VideoDetailCard(video: video[index], index: index);
            },
          ),
        ),
      ],
    );
  }
}
