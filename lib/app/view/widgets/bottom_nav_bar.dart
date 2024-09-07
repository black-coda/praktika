import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/controllers/bottom_navbar_controller/btn_nav_controller.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  ConsumerState<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  // int index = ref.watch(provider);

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [FadeEffect(), SlideEffect(begin: Offset(0, 1))],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Container(
          height: 64,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Material(
            elevation: 0.0,
            color: const Color(0xff2F2F2F),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: BottomNavigationBar(
              selectedItemColor: const Color(0xffFFFFFF),
              unselectedItemColor: const Color(0xff6C6C6C),
              unselectedFontSize: 10,
              selectedFontSize: 12,
              elevation: 0,
              currentIndex: ref.watch(indexProvider),
              onTap: (value) {
                log(value.toString(), name: "btm nav index");
                ref.watch(indexProvider.notifier).state = value;
              },
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  backgroundColor: Colors.transparent,
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                  backgroundColor: Colors.transparent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.lightbulb_outline_rounded,
                  ),
                  label: 'Learning',
                  backgroundColor: Colors.transparent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.cases_outlined),
                  label: 'Career',
                  backgroundColor: Colors.transparent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_outlined),
                  label: 'Profile',
                  backgroundColor: Colors.transparent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
