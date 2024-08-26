import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/widgets/video_card.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/features/video/model/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends ConsumerStatefulWidget {
  const VideoPlayerView({
    super.key,
    this.video,
    this.index,
  });

  final Video? video;
  final int? index;

  @override
  ConsumerState<VideoPlayerView> createState() => _VideoPlayerView2State();
}

class _VideoPlayerView2State extends ConsumerState<VideoPlayerView> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  final _overlayController = OverlayPortalController();

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.video!.videoUrl,
      ),
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Learning",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Constant.scaffoldPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.video!.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              SpacerConstant.sizedBox32,
              //TODO: Video Player
              FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the VideoPlayerController has finished initialization, use
                    // the data it provides to limit the aspect ratio of the video.
                    return Card(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    );
                  } else {
                    // If the VideoPlayerController is still initializing, show a
                    // loading spinner.
                    return VideoDetailCard(
                      video: widget.video!,
                      index: widget.index!,
                    );
                  }
                },
              ),
              SpacerConstant.sizedBox32,

              //* Video Description and Action
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.video!.description,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                          ),
                    ),
                  ),
                  SpacerConstant.sizedBox8,
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  IconButton(
                    onPressed: () {},
                    color: Colors.white,
                    icon: const Icon(
                      Icons.download_rounded,
                    ),
                  )
                ],
              ),

              //* Video Progress
              SpacerConstant.sizedBox16,
              VideoProgressIndicator(_controller, allowScrubbing: true)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          log("Floating Action Button");
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        backgroundColor: Constant.generateColor(widget.index!),
        foregroundColor: Colors.white,
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
