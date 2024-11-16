import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/widgets/header.dart';
import 'package:myapp/features/notification/model/notification_model.dart';
import 'package:myapp/features/user/controller/user_controller.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/extension/extension.dart';
import 'package:myapp/utils/loader/simmer_text.dart';
import 'package:myapp/utils/shared/animated_scroll_item_widget.dart';

import '../widgets/notification_card_widget.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(userDetailsProvider).userModel;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              centerTitle: true,
              leading: const CircleAvatar(
                  maxRadius: 15,
                  foregroundImage: NetworkImage(Constant.defaultProfileImage)),
              title: Text("Hello, ${data!.fullName}",
                  style: Constant.appBarTitleStyle(context)),
            ),
            const SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpacerConstant.sizedBox24,
                  HeaderWidget("Notifications"),
                  SpacerConstant.sizedBox24,
                ],
              ),
            ),
            SliverList.builder(
              itemBuilder: (context, index) {
                final notification = NotificationModel.notifications[index];
                return AnimatedScrollViewItem(
                  child: NotificationCardWidget(notification, index),
                );
              },
              itemCount: NotificationModel.notifications.length,
            ),
          ],
        ),
      ),
    );
  }
}
