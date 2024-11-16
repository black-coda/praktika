import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/notification/model/notification_model.dart';
import 'package:myapp/features/user/controller/user_controller.dart';
import 'package:myapp/utils/constant/constant.dart';

class NotificationCardWidget extends ConsumerStatefulWidget {
  const NotificationCardWidget(
    this.notification,
    this.index, {
    super.key,
  });

  final NotificationModel notification;
  final int index;

  @override
  ConsumerState<NotificationCardWidget> createState() =>
      _NotificationCardWidgetState();
}

class _NotificationCardWidgetState
    extends ConsumerState<NotificationCardWidget> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(userDetailsProvider).userModel;

    // Function to remove a notification

    return Dismissible(
      key: Key(widget.index.toString()),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: Constant.backgroundColorGrey,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 3))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                    maxRadius: 20,
                    foregroundImage:
                        NetworkImage(Constant.defaultProfileImage)),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      NotificationModel.deleteNotification(widget.index);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            SpacerConstant.sizedBox16,
            Text(
              "Hello, ${data!.fullName}, ${widget.notification.body}",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
