import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/widgets/header.dart';
import 'package:myapp/app/view/widgets/video_card.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/widget/custom_tile_widget.dart';
import 'package:myapp/video/controller/search_and_filter_controllers.dart';

import '../model/video_model.dart';
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
    final searchResult = ref.watch(filteredTodoListProvider);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: Constant.scaffoldPadding,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchFormWidget(controller: _controller),
                    SpacerConstant.sizedBox24,
                    if (!isSearching) ...[
                      _buildHeader(context, "Top Search"),
                      SpacerConstant.sizedBox16,
                      _buildTopSearchChips(),
                      SpacerConstant.sizedBox24,
                      _buildHeader(context, "Categories"),
                      SpacerConstant.sizedBox16,
                      ..._buildCategoryFilters(),
                    ],
                  ],
                ),
              ),
              _buildSearchResults(isSearching, searchResult),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String title) {
    return HeaderWidget(
      title,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: const Color(0xffDFDD56),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
    );
  }

  Widget _buildTopSearchChips() {
    final topSearches = [
      'Flutter',
      'Dart',
      'Riverpod',
      'UI',
      "Machine Learning",
      "Data Science"
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 2,
      children: topSearches.map((e) => _buildChip(e)).toList(),
    );
  }

  Widget _buildChip(String label) {
    return ActionChip(
      label: Text(label),
      labelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
      backgroundColor: const Color(0xff242424),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: () async {
        _controller.text = label;
        ref.read(isSearchingProvider.notifier).state = label.isNotEmpty;
        await ref.watch(filterStateProvider.notifier).searchFunction(label);
        // Implement search functionality here
      },
    );
  }

  List<Widget> _buildCategoryFilters() {
    final categories = [
      "UI/UX",
      "Illustrations",
      "Graphic design",
      "Marketing",
      "Business"
    ];
    return categories.map((category) {
      return CustomTile(
        title: category,
        onTap: () => isCategoryFilterSelected(ref, category),
        textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
        iconSize: 15.0,
        contentPadding: EdgeInsets.zero,
        isDense: true,
      );
    }).toList();
  }

  Widget _buildSearchResults(bool isSearching, List<Video> searchResult) {
    if (!isSearching) return const SliverToBoxAdapter();

    if (searchResult.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Text(
            "No result found",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
          ),
        ),
      );
    }

    return SliverList(
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
    );
  }

  void isCategoryFilterSelected(WidgetRef ref, String category) {
    //TODO: Implement category filter functionality here
  }
}
