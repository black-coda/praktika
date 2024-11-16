import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myapp/utils/constant/constant.dart';

import 'auth_view.dart';

class SessionManagementView extends StatelessWidget {
  const SessionManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.backgroundColorPurple,
      body: Padding(
        padding: EdgeInsets.only(
          left: 32,
          right: 32,
          top: MediaQuery.of(context).size.height * 0.09,
          bottom: 32,
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                "Let's start\nyour\nJourney",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Constant.backgroundColorDark,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              SpacerConstant.sizedBox56,
              Image.asset(
                'assets/logout.png',
              ),
              SpacerConstant.sizedBox64,
              LogoutButtonWidget(
                text: "Sign in",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const AuthView(isLogin: true);
                      },
                    ),
                  );
                },
              ),
              SpacerConstant.sizedBox24,
              LogoutButtonWidget(
                text: "Sign up",
                isWhite: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const AuthView(isLogin: false);
                      },
                    ),
                  );
                },
              ),
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

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isWhite = false});

  final String text;
  final void Function() onPressed;
  final bool isWhite;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            foregroundColor: const Color(0xff6C6C6C),
            textStyle: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: const Color(0xff6C6C6C)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            backgroundColor: isWhite ? Colors.white : const Color(0xffF5F378)),
        child: Text(
          text,
        ),
      ),
    );
  }
}
