import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/authentication/controller/supabase_provider.dart';
import 'package:myapp/features/video/model/video_model.dart';

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

//TODO: Continue from this feature

final filterStateProvider =
    StateNotifierProvider<SearchStateNotifier, List<Video>>((ref) {
  return SearchStateNotifier(ref);
});

//* check if search function is called
final isSearchingProvider = StateProvider.autoDispose<bool>((ref) => false);

//* filter by type
final filteredTodoListProvider = Provider<List<Video>>((ref) {
  final filter = ref.watch(filterVideoProvider);
  log(filter.toString(), name: "filter");
  final videos = ref.watch(filterStateProvider);

  final category = ref.watch(categorySearchFilterStateProvider);

  final categoryFilterMap = {
    'UI/UX': 'UI/UX',
    'Illustrations': 'Illustrations',
    'Graphic design': 'Graphic design',
    'Marketing': 'marketing',
    'Business': 'Business',
    'Web development': 'Web development',
    'Mobile development': 'Mobile development',
  };

  

  switch (filter) {
    case VideoType.lecture:
      final matchingVideos = videos
          .where((video) => (video.videoType == VideoType.lecture &&
              video.videoCategory == categoryFilterMap[category]))
          .toList();
      return matchingVideos;
    case VideoType.course:
      final matchingVideos = videos
          .where((video) => (video.videoType == VideoType.course &&
              video.videoCategory == categoryFilterMap[category]))
          .toList();
      return matchingVideos;
    case VideoType.all:
      return videos;
  }
});

///? A provider to manage the current filter type for videos.
final filterVideoProvider = StateProvider<VideoType>(
  (ref) => VideoType.all,
);

//* filter by category

///? A provider to manage the current filter category for videos.

final categorySearchFilterStateProvider = StateProvider<String?>(
  (ref) => null,
);

final categorySearchFilterProvider = Provider<List<Video>>((ref) {
  final category = ref.watch(categorySearchFilterStateProvider);

  final videos = ref.watch(filterStateProvider);

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
