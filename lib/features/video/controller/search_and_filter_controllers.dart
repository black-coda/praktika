import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/authentication/controller/supabase_provider.dart';
import 'package:myapp/features/video/model/video_model.dart';

import 'videos_controller.dart';

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

  final videos = ref.watch(filterStateProvider);

  final category = ref.watch(categorySearchFilterStateProvider);

  final categoryFilterMap = {
    'UI/UX': 'UI/UX',
    'Illustrations': 'Illustrations',
    'Graphic design': 'Graphic design',
    'Marketing': 'marketing',
    'Business': 'Business',
    'Web development': 'Web development',
    'Mobile Development': 'Mobile development',
  };

  List<Video> filterVideos(VideoType filter, String? category) {
    return videos.where((video) {
      final matchesVideoType =
          filter == VideoType.all || video.videoType == filter;
      final matchesCategory =
          category == null || video.videoCategory == category;
      return matchesVideoType && matchesCategory;
    }).toList();
  }

  switch (filter) {
    case VideoType.lecture:
    case VideoType.course:
      final matchingVideos = filterVideos(filter, category);
      log(categoryFilterMap[category] ?? 'No category',
          name: "category new bugging");
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

// final categorySearchFilterProvider = Provider<List<Video>>((ref) {
//   final category = ref.watch(categorySearchFilterStateProvider);

//   final videos = ref.watch(filterStateProvider);

//   if (category == null) {
//     return videos; // Return all videos if no category is selected
//   }

//   final categoryFilterMap = {
//     'UI/UX': 'UI/UX',
//     'Illustrations': 'Illustrations',
//     'Graphic design': 'Graphic design',
//     'Marketing': 'marketing',
//     'Business': 'Business',
//     'Web development': 'Web development',
//     'Mobile development': 'Mobile development',
//   };

//   return videos
//       .where((video) => video.videoCategory == categoryFilterMap[category])
//       .toList();
// });
