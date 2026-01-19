import 'package:mapollege/view/components/image_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/components/info_card_component.dart';
import 'package:mapollege/view/components/not_component.dart';
import 'package:mapollege/view/components/shimmer_component.dart';
import 'package:mapollege/view/presentation/public/room_screen/controller/room_controller.dart';

class RoomScreen extends GetView<RoomController> {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('ห้อง', style: theme.textTheme.titleLarge)),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return ShimmerComponent.layout(context).nested(250);
          }

          if (controller.room.value == null) {
            return const NotComponent(
              icon: Icons.meeting_room,
              label: 'ไม่มีข้อมูลห้อง',
            );
          }

          return _BuildingContent(theme: theme);
        }),
      ),
    );
  }
}

class _BuildingContent extends GetView<RoomController> {
  final ThemeData theme;

  const _BuildingContent({required this.theme});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          expandedHeight: 250,
          pinned: true,
          shape: Border(
            bottom: BorderSide(
              width: 1,
              color: theme.colorScheme.outlineVariant,
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            titlePadding: const EdgeInsets.all(16),
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                controller.room.value?.roomName ?? '-',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge,
              ),
            ),
            background: ImageComponent(
              theme: theme,
              images: controller.room.value?.images ?? [],
            ),
          ),
        ),
        SliverFillRemaining(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              InfoCardComponent(
                icon: Icons.info_outline,
                title: 'ข้อมูลห้อง',
                children: [
                  InfoRowComponent(
                    icon: Icons.door_front_door,
                    label: 'ห้อง',
                    value:
                        '${controller.room.value?.roomName} (${controller.room.value?.roomNumber})',
                  ),
                  InfoRowComponent(
                    icon: Icons.layers,
                    label: 'ชั้น',
                    value: controller.room.value?.floor,
                  ),
                  InfoRowComponent(
                    icon: (controller.room.value?.isActive ?? false)
                        ? Icons.check_circle
                        : Icons.unpublished,
                    label: 'สถานะ',
                    value: (controller.room.value?.isActive ?? false)
                        ? 'ใช้งาน'
                        : 'ไม่ใช้งาน',
                    valueColor: (controller.room.value?.isActive ?? false)
                        ? Colors.green
                        : Colors.red,
                  ),
                  InfoRowComponent(
                    icon: Icons.description,
                    label: 'รายละเอียด',
                    value: controller.room.value?.description,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
