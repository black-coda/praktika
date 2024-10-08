import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/authentication/controller/auth_controller.dart';
import 'package:myapp/features/authentication/model/auth_dto.dart';
import 'package:myapp/features/authentication/model/auth_state.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/router/router_manager.dart';
import 'package:myapp/utils/toast/toast_manager.dart';

import '../model/auth_result.dart';
import 'widget/input_field_widget.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController usernameController;
  late TextEditingController fullNameController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    emailController = TextEditingController();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
    fullNameController = TextEditingController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    fullNameController.dispose();
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
                  Text(
                    "Create\naccount",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.08,
                  ),
                  InputField(formName: "Email", controller: emailController),
                  const SizedBox(height: 16),
                  InputField(
                      formName: "Full Name", controller: fullNameController),
                  const SizedBox(height: 16),
                  InputField(
                      formName: "Username", controller: usernameController),
                  const SizedBox(height: 16),
                  InputField(
                      formName: "Password",
                      controller: passwordController,
                      isPasswordField: true),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.08,
                  ),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final model = AuthDTO(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              username: usernameController.text.trim(),
                              fullName: fullNameController.text.trim(),
                            );
                            await ref
                                .read(authStateNotifierProvider.notifier)
                                .registerWithEmailAndPassword(model, context);
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
                        child: const Text("Create an account")),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouterManager.loginRoute);
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Sign in >",
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
                        text: "Already have an account? \n",
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
