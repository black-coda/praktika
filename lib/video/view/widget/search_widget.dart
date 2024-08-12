import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/video/controller/videos_controller.dart';
import 'package:myapp/video/view/search_view.dart';

class SearchFormWidget extends ConsumerWidget {
  const SearchFormWidget({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      onChanged: (value) async {
        log(value, name: "search value changed");

        // Update the isSearching state
        ref.read(isSearchingProvider.notifier).state = value.isNotEmpty;

        // Perform search and update the search results
        if (value.isNotEmpty) {
          await ref.watch(searchStateProvider.notifier).searchFunction(value);
          // ref.read(searchResultProvider.notifier).state = results;
        } else {
          // ref.read(searchResultProvider.notifier).state = [];
        }
      },
      cursorColor: Colors.white,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
      controller: _controller,
      enableSuggestions: true,
      decoration: InputDecoration(
        focusColor: Colors.white,
        prefixIcon: const Icon(Icons.search),
        prefixIconColor: Colors.white,
        suffixIconColor: Colors.white,
        suffixIcon: IconButton(
            onPressed: () {}, icon: const Icon(Icons.filter_list_rounded)),
        hintStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(color: Colors.white, width: 1.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(color: Colors.white, width: 1.5),
        ),
      ),
    );
  }
}
