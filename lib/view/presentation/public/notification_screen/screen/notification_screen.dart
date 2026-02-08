import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/components/appbar_component.dart';
import 'package:mapollege/view/components/search_component.dart';
import 'package:mapollege/view/presentation/public/notification_screen/controller/notification_controller.dart';
import 'package:mapollege/view/presentation/public/notification_screen/widget/notification_list_widget.dart';
import 'package:mapollege/view/presentation/public/notification_screen/widget/notification_pagination_widget.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => controller.refreshNotification(),
            child: _NotificationScreenContent(),
          ),
        ),
      ),
    );
  }
}

class _NotificationScreenContent extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller.scrollController,
      slivers: [
        AppbarComponent().sliver(title: 'การแจ้งเตือน', floating: true),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          sliver: SliverToBoxAdapter(
            child: SearchComponents(
              title: 'ค้นหาการแจ้งเตือน...',
              controller: controller.searchController,
              onChanged: (value) => controller.onSearchChanged(value),
            ),
          ),
        ),
        const NotificationListWidget(),
        const NotificationPaginationWidget(),
      ],
    );
  }
}
