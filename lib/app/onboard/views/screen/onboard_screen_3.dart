import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myapp/features/authentication/view/auth_view.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/extension/extension.dart';

class OnboardScreen3 extends StatelessWidget {
  const OnboardScreen3({super.key, required this.controller});
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.backgroundColorOrange,
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 16, right: 16),
        child: Center(
          child: Column(
            children: [
              Text(
                "Learn new\nonline from\nthe best\nexperts",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Constant.backgroundColorDark,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              SpacerConstant.sizedBox64,
              Image.asset(
                'assets/sub.png',
              ),
              SpacerConstant.sizedBox64,
              TextButton(
                onPressed: () => {
                  log("to auth view", name: "OnboardScreen3"),
                  Navigator.of(context)
                      .animateTo(const AuthView(isLogin: true)),
                },
                child: Text(
                  "Next",
                  style: Constant.underlineStyle(context,
                      color: Constant.backgroundColorDark),
                ),
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


