import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'onboard_screen_1.dart';
import 'onboard_screen_2.dart';
import 'onboard_screen_3.dart';

class OnboardEntryScreen extends ConsumerStatefulWidget {
  const OnboardEntryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardEntryScreenState();
}

class _OnboardEntryScreenState extends ConsumerState<OnboardEntryScreen> {
  static PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        OnboardScreen1(controller: pageController),
        OnboardScreen2(controller: pageController),
        OnboardScreen3(controller: pageController),
      ]// uses `Animate.defaultDuration`
          // .scale() // inherits duration from fadeIn
          // .move(delay: 300.ms, duration: 600.ms),
    );
  }
}
