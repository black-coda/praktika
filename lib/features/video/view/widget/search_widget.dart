import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/video/controller/search_and_filter_controllers.dart';
import 'package:myapp/features/video/view/search_filter_view.dart';

class SearchFormWidget extends ConsumerWidget {
  const SearchFormWidget({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var overlayController = OverlayPortalController();
    return TextFormField(
      onChanged: (value) async {
        log(value, name: "search value changed");

        // Update the isSearching state
        ref.read(isSearchingProvider.notifier).state = value.isNotEmpty;

        // Perform search and update the search results
        if (value.isNotEmpty) {
          await ref.watch(filterStateProvider.notifier).searchFunction(value);
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
        suffixIcon: OverlayPortal(
          controller: overlayController,
          overlayChildBuilder: (context) => const Align(
            alignment: Alignment.topCenter,
            child: SearchFilterView1(),
          ),
          child: IconButton(
              onPressed: () {
                //* show filter overlay dialog
                // overlayController.toggle();

                //* Navigate to filter screen
                Navigator.pushNamed(context, '/searchFilter');
              },
              icon: const Icon(Icons.filter_list_rounded)),
        ),
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
