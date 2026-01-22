import 'package:mapollege/core/model/people/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/components/not_component.dart';
import 'package:mapollege/view/components/shimmer_component.dart';
import 'package:mapollege/view/presentation/private/notification_screen/controller/notification_controller.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text('แจ้งเตือน', style: theme.textTheme.titleLarge),
        shape: Border(
          bottom: BorderSide(width: 1, color: theme.colorScheme.outlineVariant),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return ShimmerComponent(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 3,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    4,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 3,
                      ),
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          if (controller.notifications.isEmpty) {
            return const NotComponent(
              icon: Icons.notifications_off,
              label: 'ไม่มีการแจ้งเตือน',
            );
          }

          return _buildContent(theme);
        }),
      ),
    );
  }

  Widget _buildContent(ThemeData theme) {
    final List<NotificationModel> notifications = controller.notifications;

    return RefreshIndicator(
      onRefresh: controller.refreshNotifications,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return _buildNotificationItem(theme, item);
        },
      ),
    );
  }

  Widget _buildNotificationItem(ThemeData theme, NotificationModel item) {
    return Card(
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(
            Icons.notifications_active,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(item.title, style: theme.textTheme.titleMedium),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              item.message,
              style: theme.textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              "${item.createdAt?.day}/${item.createdAt?.month}/${item.createdAt?.year} ${item.createdAt?.hour}:${item.createdAt?.minute}",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
