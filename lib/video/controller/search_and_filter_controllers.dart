import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/authentication/controller/supabase_provider.dart';
import 'package:myapp/video/model/video_model.dart';

import 'videos_controller.dart';

// final queryProvider = StateProvider<String>((ref) {
//   return "";
// });

// final filterFunctionProvider = FutureProvider<List<Video>>((ref) async {
//   final videos = ref.watch(videoNotifierProvider);
//   final query = ref.watch(queryProvider);
//   return videos
//       .where((Video video) =>
//           video.title.toLowerCase().contains(query.toLowerCase()) ||
//           video.description.toLowerCase().contains(query.toLowerCase()))
//       .toList();
// });


class SearchStateNotifier extends StateNotifier<List<Video>> {
  SearchStateNotifier(this.ref) : super([]);

  final Ref ref;

  //? search feature
  Future<List<Video>> searchFunction(String query) async {
    final result = await ref
        .read(supabaseProvider)
        .from('videos')
        .select()
        .ilike("title_description", '%$query%');

    log(result.length.toString(), name: "search result");
    final videos = result.map((e) => Video.fromMap(e)).toList();
    state = videos;
    return state;
  }
}

final filterStateProvider =
    StateNotifierProvider<SearchStateNotifier, List<Video>>((ref) {
  return SearchStateNotifier(ref);
});

//* check if search function is called
final isSearchingProvider = StateProvider.autoDispose<bool>((ref) => false);



//* filter by type
final filteredTodoListProvider = Provider<List<Video>>((ref) {
  final filter = ref.watch(filterVideoProvider);
  final videos = ref.watch(filterStateProvider);

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
