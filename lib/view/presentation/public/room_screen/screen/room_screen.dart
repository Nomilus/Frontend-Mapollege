import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mapollege/config/router/routes.dart';
import 'package:mapollege/view/components/appbar_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/presentation/public/room_screen/controller/room_controller.dart';
import 'package:mapollege/view/presentation/public/room_screen/widget/room_info_widget.dart';

class RoomScreen extends GetView<RoomController> {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.refreshRoom(),
          child: const _RoomScreenContent(),
        ),
      ),
    );
  }
}

class _RoomScreenContent extends GetView<RoomController> {
  const _RoomScreenContent();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        AppbarComponent().sliver(
          title: 'ห้อง',
          actions: [
            if (Get.previousRoute == Routes.public.search)
              IconButton(
                onPressed: () {
                  controller.goBuilding();
                  Get.until((route) => Get.currentRoute == Routes.public.home);
                },
                icon: const FaIcon(Icons.apartment),
              ),
          ],
        ),
        const RoomInfoWidget(),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }
}
