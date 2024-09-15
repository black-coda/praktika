import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/app/controllers/bottom_navbar_controller/btn_nav_controller.dart';
import 'package:myapp/app/view/widgets/header.dart';
import 'package:myapp/app/view/widgets/video_card.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/features/video/controller/videos_controller.dart';

class MyLearningView extends ConsumerWidget {
  const MyLearningView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //* check if favorite videos is empty
    final favoriteVideos = ref.watch(favoriteVideosProvider);
    if (favoriteVideos.isEmpty) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(Constant.lottieNoData),
                SpacerConstant.sizedBox24,
                TextButton(
                  onPressed: () =>
                      ref.read(indexProvider.notifier).update((i) => i = 0),
                  child: Text("Go to Dashboard screen",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white)),
                )
              ],
            ),
          ),
        ),
      );
    }
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
                SpacerConstant.sizedBox16,
                VideoCard(
                  videosList:
                      ref.watch(courseVideoProvider(favoriteVideosProvider)),
                ),
                SpacerConstant.sizedBox24,
                const HeaderWidget("Lectures"),
                SpacerConstant.sizedBox16,
                VideoCard(
                  videosList:
                      ref.watch(lectureVideoProvider(favoriteVideosProvider)),
                ),
                const SizedBox(height: 12),

                //TODO: Implement trending/top/featured videos here
              ],
            ),
          ),
        ),
      ],
    );
  }
}
