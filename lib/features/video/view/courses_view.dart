import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/widgets/video_card.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/features/video/controller/videos_controller.dart';
import 'package:myapp/features/video/model/video_model.dart';
import 'package:myapp/features/video/view/video_player_view.dart';





class CourseDetailView extends ConsumerWidget {
  const CourseDetailView({super.key, this.video, this.index});
  final Video? video;
  final int? index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Course Detail',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Constant.scaffoldPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///? video detail card
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return VideoPlayerView(
                      video: video!,
                      index: index!,
                    );
                  }),);
                },
                child: VideoDetailCard(
                  video: video!,
                  index: index!,
                ),
              ),

              ///? Title
              SpacerConstant.sizedBox20,
              Text(
                video!.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w400),
              ),
              SpacerConstant.sizedBox20,
              //? Description
              Text(
                video!.description.isNotEmpty
                    ? video!.description
                    : "Discover the power of Flutter! This video covers the essentials of building beautiful, native-like apps for iOS and Android using a single codebase. From installation to creating your first app, we've got you covered.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w200),
                textAlign: TextAlign.justify,
              ),

              ///?

              SpacerConstant.sizedBox40,

              ///? Add to favorite
              Row(
                children: [
                  Text(
                    'Add to your learning',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w100),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      final isFav = ref.watch(favoriteVideosProvider);
                      isFav.contains(video!)
                          ? ref
                              .watch(videoNotifierProvider.notifier)
                              .removeFromMyLearning(video!.id)
                          : ref
                              .watch(videoNotifierProvider.notifier)
                              .addToMyLearning(video!.id);
                      ref
                          .refresh(videoNotifierProvider.notifier)
                          .fetchVideosFromDB();
                      // await ref
                      //     .watch(videoNotifierProvider.notifier)
                      //     .fetchVideosFromDB();
                    },
                    icon: Consumer(
                      builder: (context, ref, child) {
                        return Icon(
                          ref.watch(favoriteVideosProvider).contains(video!)
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: Colors.white,
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
