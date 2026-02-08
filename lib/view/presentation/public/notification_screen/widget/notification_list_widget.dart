import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mapollege/core/utility/dialog_utility.dart';
import 'package:mapollege/view/components/not_component.dart';
import 'package:mapollege/view/components/shimmer_component.dart';
import 'package:mapollege/view/presentation/public/notification_screen/controller/notification_controller.dart';
import 'package:mapollege/view/presentation/public/notification_screen/widget/notification_dialog_widget.dart';
import 'package:mapollege/view/presentation/public/notification_screen/widget/notification_item_widget.dart';

class NotificationListWidget extends GetView<NotificationController> {
  const NotificationListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Obx(() {
      if (controller.isLoading.value) {
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: ShimmerComponent(
              child: Column(
                spacing: 8,
                children: List.generate(
                  3,
                  (index) => Container(
                    width: double.infinity,
                    height: 130,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }

      if (controller.notifications.isEmpty) {
        return SliverFillRemaining(
          child: Center(
            child: NotComponent(
              icon: controller.searchQuery.value.isEmpty
                  ? FontAwesomeIcons.solidBellSlash
                  : FontAwesomeIcons.ban,
              label: controller.searchQuery.value.isEmpty
                  ? 'ไม่มีการแจ้งเตือน'
                  : 'ไม่พบผลลัพธ์',
            ),
          ),
        );
      }

      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList.separated(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) => NotificationItemWidget(
            notification: controller.notifications[index],
            onTap: () => DialogUtility.showCustom(
              child: NotificationDialogWidget(
                notification: controller.notifications[index],
              ),
            ),
          ),
          separatorBuilder: (_, __) => const SizedBox(height: 8),
        ),
      );
    });
  }
}
