import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/screens/dashboard_screen.dart';
import 'package:myapp/features/authentication/controller/auth_controller.dart';
import 'package:myapp/features/authentication/model/auth_dto.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/extension/extension.dart';
import 'package:myapp/utils/toast/toast_manager.dart';

import '../model/auth_result.dart';
import 'auth_view.dart';
import 'widget/input_field_widget.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    emailController = TextEditingController();
    passwordController = TextEditingController();

    //! animation controller
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log(state.name);
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    final authResult = ref.watch(authStateNotifierProvider).result;
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
                  Text(
                    "Hello\nagain!",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.1,
                  ),
                  InputField(formName: "Email", controller: emailController),
                  const SizedBox(height: 20),
                  InputField(
                      formName: "Password", controller: passwordController, isPasswordField: true),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.1,
                  ),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final model = AuthDTO(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                            await ref
                                .read(authStateNotifierProvider.notifier)
                                .loginWithEmailAndPassword(model, context)
                                .then((_) {
                              if (authResult != null) {
                                log(authResult.toString(), name: "Login View");
                                switch (authResult) {
                                  case Success():
                                    ToastManager()
                                        .showToast(context, authResult.msg!);

                                  case Error():
                                    ToastManager()
                                        .showToast(context, authResult.msg!);
                                }
                              }
                            });
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
                  //? navigate to sign up screen
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushAnimated(const AuthView(isLogin: false));
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
                ]
                    .animate(interval: 100.ms)
                    .fadeIn(duration: 300.ms)
                    .moveX(delay: 100.ms),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
