import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/widgets/header.dart';
import 'package:myapp/features/user/controller/user_controller.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/extension/extension.dart';
import 'package:myapp/utils/loader/simmer_text.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(userDetailsProvider).userModel;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const CircleAvatar(
            maxRadius: 15,
            foregroundImage: NetworkImage(Constant.defaultProfileImage)),
        title: Text("Hello, ${data!.fullName}",
            style: Constant.appBarTitleStyle(context)),
      ),
      body: const Padding(
        padding: Constant.scaffoldPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidget("Notifications"),
            ],
          ),
        ),
      ),
    );
  }
}
