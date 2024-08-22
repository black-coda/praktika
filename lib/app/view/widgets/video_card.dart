import 'package:flutter/material.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/extension/extension.dart';
import 'package:myapp/features/video/model/video_model.dart';
import 'package:myapp/features/video/view/courses_view.dart';
import 'rating_button.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({
    super.key,
    required this.videosList,
  });

  final List<Video> videosList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 184,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              ///? Navigate to the course detail view
              final Video video = videosList[index];
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CourseDetailView(
                    video: video,
                    index: index,
                  ),
                ),
              );
            },
            child: Padding(
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
                padding: const EdgeInsets.all(10),
                width: 280,
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            videosList[index].title,
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
                    //? price widget
                    Positioned(
                      bottom: 35,
                      left: 0,
                      child: Text(
                        "${videosList[index].price.toString()} \$",
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
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
                          //? Ratings
                          SizedBox(
                            height: 24,
                            width: 60,
                            child: ChipElevatedBtn(
                              index: index,
                              ratings: "4.5",
                            ),
                          ),
                          const SizedBox(width: 4),
                          //? Duration
                          SizedBox(
                            height: 24,
                            width: 60,
                            child: ChipElevatedBtn(
                              index: index,
                              ratings: videosList[index]
                                  .duration
                                  .toFormattedString(),
                              isDurationField: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //? price, tags,
                    Align(
                      alignment: Alignment.bottomRight,
                      widthFactor: 0,
                      child: SizedBox(
                        height: 140,
                        child: Image.asset(
                          "assets/img_2.png",
                          width: 150,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: videosList.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class VideoDetailCard extends StatelessWidget {
  const VideoDetailCard({
    super.key,
    required this.video,
    required this.index,
  });

  final Video video;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            margin: EdgeInsets.zero,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Constant.coloringMethod(index),
              ),
              padding: const EdgeInsets.all(10),
              width: double.maxFinite,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 300,
                        child: Text(
                          video.title,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                color: const Color(0xff242424),
                                fontWeight: FontWeight.w500,
                                fontSize: 32,
                              ),
                        ),
                      ),
                      const Icon(Icons.favorite_border_outlined, size: 20)
                    ],
                  ),

                  Positioned(
                    bottom: 35,
                    left: 0,
                    child: Text(
                      "${video.price.toString()} \$",
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
                        //? Ratings
                        SizedBox(
                          height: 24,
                          width: 60,
                          child: ChipElevatedBtn(
                            index: index,
                            ratings: "4.5",
                          ),
                        ),
                        const SizedBox(width: 4),
                        //? Duration
                        SizedBox(
                          height: 24,
                          width: 60,
                          child: ChipElevatedBtn(
                            index: index,
                            ratings: video.duration.toFormattedString(),
                            isDurationField: true,
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///? Illustration tag
                  Positioned(
                    top: 30,
                    right: 0,
                    child: SizedBox(
                      // height: 140,
                      child: Image.asset(
                        "assets/img_2.png",
                        width: 150,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
