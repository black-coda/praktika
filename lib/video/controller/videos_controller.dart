import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/authentication/controller/supabase_provider.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/video/model/video_model.dart';

/// A state notifier class to manage the state of a list of videos.
class VideoNotifier extends StateNotifier<List<Video>> {
  VideoNotifier(this.ref) : super(<Video>[]);

  final Ref ref;

  ///? Fetches videos from the database, including their associated reviews.
  ///
  ///? Returns a list of `Video` objects.
  Future<List<Video>> fetchVideosFromDB() async {
    final supabase = ref.watch(supabaseProvider);
    final user = supabase.auth.currentUser;

    if (user == null) return [];
    final data = await supabase
        .from(Constant.videoTable)
        .select('*, reviews(rating), my_learning(is_favorite)')
        .eq("my_learning.user_id", user.id);
    final videos = data.map((e) => Video.fromMap(e)).toList();

    state = videos;
    return state;
  }

  ///? Fetches the review of a specific video by its ID.
  ///
  ///? Returns the rating of the review as a `String`.
  Future<String> getVideoReviewFromDB(int videoID) async {
    final supabase = ref.watch(supabaseProvider);
    final data = await supabase
        .from(Constant.reviewTable)
        .select()
        .eq("video_id", videoID);
    log(data.first.toString(), name: "video review");
    log(data.first["rating"].toString());
    return data.first["rating"].toString();
  }

  //? Add to favorite video
  /// Adds a video to the list of favorite videos.
  Future<bool> addToMyLearning(int videoID) async {
    final supabase = ref.watch(supabaseProvider);
    final user = supabase.auth.currentUser;
    if (user != null) {
      try {
        await supabase.from(Constant.favoriteTable).insert({
          "user_id": user.id,
          "video_id": videoID,
        });
        log("added to favorite", name: "added to favorite");
        return true;
      } catch (e) {
        log(e.toString(), name: "add to favorite error");
        return false;
      }
    }
    return false;
  }

  //? Remove from favorite video
  /// Removes a video from the list of favorite videos.
  Future<bool> removeFromMyLearning(int videoID) async {
    final supabase = ref.watch(supabaseProvider);
    final user = supabase.auth.currentUser;
    if (user != null) {
      try {
        await supabase
            .from(Constant.favoriteTable)
            .delete()
            .eq("video_id", videoID);
        log("removed from favorite", name: "removed from favorite");
        return true;
      } catch (e) {
        log(e.toString(), name: "remove from favorite error");
        return false;
      }
    }
    return false;
  }
}

///? A provider for the `VideoNotifier` class, managing a list of `Video` objects.
final videoListProvider =
    StateNotifierProvider<VideoNotifier, List<Video>>((ref) {
  return VideoNotifier(ref);
});

///? A provider to filter the list of videos based on their type.
final filteredTodoListProvider = Provider<List<Video>>((ref) {
  final filter = ref.watch(filterVideoProvider);
  final videos = ref.watch(videoListProvider);

  switch (filter) {
    case VideoType.lecture:
      final lectureVideos = videos
          .where((video) => video.videoType == VideoType.lecture)
          .toList();
      return lectureVideos;
    case VideoType.course:
      final courseVideos =
          videos.where((video) => video.videoType == VideoType.course).toList();
      return courseVideos;
    case VideoType.all:
      return videos;
  }
});

///? A provider to manage the current filter type for videos.
final filterVideoProvider = StateProvider<VideoType>(
  (ref) => VideoType.all,
);

/// A provider to filter and return only videos of type `course`.
final courseVideoProvider =
    Provider.family<List<Video>, AlwaysAliveProviderBase<List<Video>>>(
        (ref, videoListProvider) {
  final videos = ref.watch(videoListProvider);
  return videos.where((video) => video.videoType == VideoType.course).toList();
});

/// A provider to filter and return only videos of type `lecture`.
final lectureVideoProvider =
    Provider.family<List<Video>, AlwaysAliveProviderBase<List<Video>>>(
        (ref, videoListProvider) {
  final videos = ref.watch(videoListProvider);
  return videos.where((video) => video.videoType == VideoType.lecture).toList();
});

///TODO: A provider to fetch videos with rating greater than 3

///* A future provider to fetch the list of videos from the database asynchronously.
final videosFutureProvider = FutureProvider<List<Video>>((ref) async {
  final videos =
      await ref.watch(videoListProvider.notifier).fetchVideosFromDB();
  return videos;
});

//? check for is favorite
final favoriteVideosProvider = Provider<List<Video>>((ref) {
  //? makes reference to the videos provider from the StateNotifier
  final videos = ref.watch(videoListProvider);
  return videos.where((video) => video.isFavorite).toList();
});

//? category filter providers

final categoryStateProvider = StateProvider<String?>(
  (ref) => null,
);

final categoryFilterProvider = Provider<List<Video>>((ref) {
  final category = ref.watch(categoryStateProvider);

  final videos = ref.watch(videoListProvider);

  if (category == null) {
    return videos; // Return all videos if no category is selected
  }

  final categoryFilterMap = {
    'UI/UX': 'UI/UX',
    'Illustrations': 'Illustrations',
    'Graphic design': 'Graphic design',
    'Marketing': 'marketing',
    'Business': 'Business',
    'Web development': 'Web development',
    'Mobile development': 'Mobile development',
  };

  return videos
      .where((video) => video.videoCategory == categoryFilterMap[category])
      .toList();
});
