import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/widgets/video_card.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/video/controller/videos_controller.dart';

class MyLearning extends ConsumerWidget {
  const MyLearning({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final video = ref.watch(isFavoriteVideosProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Learning',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: Constant.scaffoldPadding,
        child: SizedBox(
          child: Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: video.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 12);
              },
              itemBuilder: (BuildContext context, int index) {
                return VideoDetailCard(video: video[index], index: index);
              },
            ),
          ),
        ),
      )),
    );
  }
}