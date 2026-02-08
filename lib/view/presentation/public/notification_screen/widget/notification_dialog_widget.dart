import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mapollege/core/model/people/notification_model.dart';
import 'package:mapollege/core/utility/date_utility.dart';
import 'package:mapollege/view/presentation/public/notification_screen/controller/notification_controller.dart';

class NotificationDialogWidget extends GetView<NotificationController> {
  const NotificationDialogWidget({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: theme.colorScheme.surfaceContainerHigh,
                  ),
                  color: theme.colorScheme.surfaceContainer,
                ),
                child: Text(
                  notification.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    width: 1,
                    color: theme.colorScheme.surfaceContainerHigh,
                  ),
                  color: theme.colorScheme.surfaceContainer,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 6,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.clock,
                            size: 12,
                            color: theme.colorScheme.primary,
                          ),
                          Text(
                            DateUtility.timeAgo(notification.createdAt),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: theme.colorScheme.surfaceContainerHigh,
                  ),
                  color: theme.colorScheme.surfaceContainer,
                ),
                child: Text(
                  notification.message,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
