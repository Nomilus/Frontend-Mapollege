import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/presentation/public/notification_screen/controller/notification_controller.dart';

class NotificationPaginationWidget extends GetView<NotificationController> {
  const NotificationPaginationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Obx(() {
      if (controller.isLoading.value ||
          controller.notifications.isEmpty ||
          controller.totalPages.value <= 1) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }

      final int currentPage = controller.currentPage.value;
      final int totalPages = controller.totalPages.value;

      return SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                offset: const Offset(0, -1),
                blurRadius: 3,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: currentPage > 0
                    ? () {
                        controller.currentPage.value = 0;
                        controller.goToPage(0);
                        controller.scrollToTop();
                      }
                    : null,
                icon: const Icon(Icons.first_page),
              ),
              IconButton(
                onPressed: currentPage > 0
                    ? () {
                        controller.previousPage();
                        controller.scrollToTop();
                      }
                    : null,
                icon: const Icon(Icons.chevron_left),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'หน้า ${currentPage + 1} จาก $totalPages',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: currentPage < totalPages - 1
                    ? () {
                        controller.nextPage();
                        controller.scrollToTop();
                      }
                    : null,
                icon: const Icon(Icons.chevron_right),
              ),
              IconButton(
                onPressed: currentPage < totalPages - 1
                    ? () {
                        controller.currentPage.value = totalPages - 1;
                        controller.goToPage(totalPages - 1);
                        controller.scrollToTop();
                      }
                    : null,
                icon: const Icon(Icons.last_page),
              ),
            ],
          ),
        ),
      );
    });
  }
}
