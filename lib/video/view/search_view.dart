import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/widgets/header.dart';
import 'package:myapp/app/view/widgets/video_card.dart';
import 'package:myapp/authentication/controller/supabase_provider.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/widget/custom_tile_widget.dart';
import 'package:myapp/video/controller/videos_controller.dart';

import 'widget/search_widget.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSearching = ref.watch(isSearchingProvider);

    final searchResult = ref.watch(searchStateProvider);

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: Constant.scaffoldPadding,
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //? Search bar
                    SearchFormWidget(controller: _controller),
                    SpacerConstant.sizedBox24,
                    if (!isSearching)
                      HeaderWidget(
                        "Top Search",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: const Color(0xffDFDD56),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                      ),
                    if (!isSearching) SpacerConstant.sizedBox16,
                    if (!isSearching)
                      //? Top search chips
                      Wrap(
                        spacing: 8,
                        runSpacing: 2,
                        children: [
                          ...[
                            'Flutter',
                            'Dart',
                            'Riverpod',
                            'UI',
                            "Machine Learning",
                            "Data Science",
                          ].map(
                            (e) => ActionChip(
                              label: Text(e),
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                              backgroundColor: const Color(0xff242424),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              onPressed: () {
                                _controller.text = e;
                                //TODO:  Implement search functionality here
                              },
                            ),
                          ),
                        ],
                      ),
                    //? filter by category
                    if (!isSearching) SpacerConstant.sizedBox24,
                    if (!isSearching)
                      HeaderWidget(
                        "Categories",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: const Color(0xffDFDD56),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                      ),
                    if (!isSearching) SpacerConstant.sizedBox16,
                    if (!isSearching)
                      ...[
                        "UI/UX",
                        "Illustrations",
                        "Graphic design",
                        "Marketing",
                        "Business",
                      ].map(
                        (category) => CustomTile(
                          title: category,
                          onTap: () {
                            isCategoryFilterSelected(ref, category);
                          },
                          textStyle:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                          iconSize: 15.0,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            //? Implement search result here
            if (isSearching)
              searchResult.isEmpty
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          "No result found",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final video = searchResult[index];
                          return VideoDetailCard(
                            video: video,
                            index: index,
                          );
                        },
                        childCount: searchResult.length,
                      ),
                    ),
          ],
        ),
      ),
    );
  }

  void isCategoryFilterSelected(WidgetRef ref, String category) {}
}

final isSearchingProvider = StateProvider<bool>((ref) {
  return false;
});
