import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/authentication/controller/auth_controller.dart';
import 'package:myapp/authentication/model/auth_dto.dart';
import 'package:myapp/authentication/model/auth_state.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/router/router_manager.dart';
import 'package:myapp/utils/toast/toast_manager.dart';

import 'widget/input_widget.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //! animation controller
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    emailController = TextEditingController();
    passwordController = TextEditingController();

    //! animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    // _animation = CurvedAnimation(
    //   parent: _animationController,
    //   curve: Curves.bounceInOut,
    // );

    _animation = Tween<double>(begin: 50, end: 0).animate(_animationController);
    _opacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    emailController.dispose();
    passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log(state.name);
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: Constant.scaffoldPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    // child: child,
                    builder: (BuildContext context, Widget? child) {
                      // log(_animation.value.toString());
                      return Transform.translate(
                        offset: Offset(0, _animation.value),
                        child: AnimatedOpacity(
                          opacity: _opacityAnimation.value,
                          duration: const Duration(seconds: 3),
                          child: Text(
                            "Hello\nagain!",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.1,
                  ),
                  InputField(formName: "Email", controller: emailController),
                  const SizedBox(height: 20),
                  InputField(
                      formName: "Password", controller: passwordController),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.1,
                  ),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final model = AuthDTO(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                            final msg = await ref
                                .read(authStateNotifierProvider.notifier)
                                .loginWithEmailAndPassword(model);
                            switch (msg) {
                              case Success():
                                ToastManager()
                                    .showToast(context, "Login successful 🥰");

                              case Error():
                                ToastManager().showToast(context, msg.msg);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xff6C6C6C),
                            textStyle: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: const Color(0xff6C6C6C)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                            backgroundColor: const Color(0xffF5F378)),
                        child: const Text("Log in")),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouterManager.registerRoute);
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Sign up  >",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
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
          ),
        ),
      ),
    );
  }
}
