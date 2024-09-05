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
        leading: const CircleAvatar(
            maxRadius: 15,
            foregroundImage: NetworkImage(Constant.defaultProfileImage)),
        title: Text("Hello, ${data.fullName}",
            style: Constant.appBarTitleStyle(context)),
        actions: [
          IconButton(
            onPressed: () {
              context.push(const NotificationScreen());
            },
            icon: Badge.count(
              count: 2,
              child: const Icon(
                Icons.notifications,
                color: Color(0xff6C6C6C),
              ),
            ),
            padding: EdgeInsets.zero,
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.zero,
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
