import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myapp/utils/constant/constant.dart';

class OnboardScreen1 extends StatelessWidget {
  const OnboardScreen1({super.key, required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.backgroundColorPurple,
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 16, right: 16),
        child: Center(
          child: Column(
            children: [
              Text(
                "Welcome\nto Praktika\nSchool",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Constant.backgroundColorDark,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              SpacerConstant.sizedBox56,
              Image.asset(
                'assets/onboard2.png',
              ),
              SpacerConstant.sizedBox64,
              TextButton(
                child: Text(
                  "Next",
                  style: Constant.underlineStyle(context,
                      color: Constant.backgroundColorDark),
                ),
                onPressed: () {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInExpo,
                  );
                },
              )
            ]
                .animate(interval: 400.ms)
                .fadeIn() // uses `Animate.defaultDuration`
                .scale() // inherits duration from fadeIn
                .move(delay: 300.ms, duration: 600.ms),
          ),
        ),
      ),
    );
  }
}
