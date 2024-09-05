import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/extension/extension.dart';
import 'package:myapp/utils/router/router_manager.dart';

class AuthView extends ConsumerWidget {
  final bool isLogin;

  const AuthView({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Constant.backgroundColorPurple,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: MediaQuery.sizeOf(context).height * 0.1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isLogin ? "Log in\nwith" : "Create account",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 36),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
            AuthButtonWidget(
              () {
                log("to email view", name: "AuthView");
                Navigator.pushNamed(
                  context,
                  isLogin
                      ? RouterManager.loginRoute
                      : RouterManager.registerRoute,
                );
              },
              isLogin: isLogin,
              icon: const Icon(Icons.email),
              text: "email",
            ),
            SpacerConstant.sizedBox24,
            AuthButtonWidget(
              () {
                //TODO: Implement Google Auth
              },
              isLogin: isLogin,
              icon: const FaIcon(FontAwesomeIcons.google),
              text: "Google",
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
            GestureDetector(
              onTap: () {
                ///* Navigate to the opposite view
                ///* If the current view is login, navigate to register view
                ///* If the current view is register, navigate to login view
                isLogin
                    ? Navigator.of(context)
                        .pushAnimated(const AuthView(isLogin: false))
                    : Navigator.of(context)
                        .pushAnimated(const AuthView(isLogin: true));
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: isLogin ? "Sign up  >" : "Sign in  >",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                    ),
                  ],
                  text: "Don't have an account? \n",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget(
    this.onPressed, {
    super.key,
    required this.isLogin,
    required this.icon,
    required this.text,
  });

  final bool isLogin;
  final Widget icon;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Constant.backgroundColorDark,
          foregroundColor: Constant.backgroundColorPurple,
          side: const BorderSide(color: Constant.backgroundColorPurple),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            Text(isLogin ? 'Login with $text' : 'Register with $text'),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
