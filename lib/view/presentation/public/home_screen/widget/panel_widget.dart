import 'package:mapollege/config/router/routes.dart';
import 'package:mapollege/view/components/delegate_component.dart';
import 'package:mapollege/view/components/image_component.dart';
import 'package:mapollege/view/components/info_card_component.dart';
import 'package:mapollege/view/components/not_component.dart';
import 'package:mapollege/view/components/shimmer_component.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/panel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:get/get.dart';

class PanelWidget extends GetView<PanelController> {
  const PanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SlidingUpPanelWidget(
      controlHeight: 36.0,
      anchor: 0.4,
      panelController: controller.panelController.value,
      enableOnTap: true,
      onTap: () {
        if (SlidingUpPanelStatus.expanded ==
            controller.panelController.value.status) {
          controller.panelController.value.collapse();
        } else {
          controller.panelController.value.expand();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: DefaultTabController(
          length: 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Obx(
                () => Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text('อาคาร', style: theme.textTheme.titleMedium),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    if (controller.building.value != null)
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.qr_code),
                      ),
                    IconButton(
                      onPressed: () {
                        controller.panelController.value.collapse();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return ShimmerComponent.layout(context).nested();
                  }

                  if (controller.building.value == null) {
                    return const NotComponent(
                      icon: Icons.apartment,
                      label: 'ไม่มีข้อมูลอาคาร',
                    );
                  }

                  return _BuildingContent(theme: theme);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildingContent extends GetView<PanelController> {
  final ThemeData theme;
  const _BuildingContent({required this.theme});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          expandedHeight: 250,
          pinned: true,
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
                controller.building.value?.name ?? '-',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge,
              ),
            ),
            background: ImageComponent(
              theme: theme,
              images: controller.building.value?.images ?? [],
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverTabBarDelegate(
            tabBar: TabBar(
              isScrollable: true,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
              indicatorColor: theme.colorScheme.primary,
              indicatorWeight: 3,
              tabs: [
                const Tab(text: 'ข้อมูลอาคาร'),
                Tab(text: 'ห้อง (${controller.building.value?.rooms.length})'),
                Tab(
                  text:
                      'แผนก (${controller.building.value?.departments.length})',
                ),
                Tab(text: 'งาน (${controller.building.value?.works.length})'),
              ],
            ),
          ),
        ),
      ],
      body: TabBarView(
        children: [
          _BuildingInfoTab(theme: theme),
          _RoomsTab(theme: theme),
          _DepartmentsTab(theme: theme),
          _WorksTap(theme: theme),
        ],
      ),
    );
  }
}

class _BuildingInfoTab extends GetView<PanelController> {
  final ThemeData theme;
  const _BuildingInfoTab({required this.theme});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        InfoCardComponent(
          icon: Icons.info_outline,
          title: 'ข้อมูลทั่วไป',
          children: [
            if (controller.building.value!.description.isNotEmpty)
              InfoRowComponent(
                icon: Icons.description,
                label: 'รายละเอียด',
                value: controller.building.value?.description,
              ),
            InfoRowComponent(
              icon: Icons.location_on,
              label: 'ที่อยู่',
              value: controller.building.value?.address,
            ),
            InfoRowComponent(
              icon: Icons.layers,
              label: 'จำนวนชั้น',
              value: '${controller.building.value?.floorCount} ชั้น',
            ),
            InfoRowComponent(
              icon: (controller.building.value?.isActive ?? false)
                  ? Icons.check_circle
                  : Icons.unpublished,
              label: 'สถานะ',
              value: (controller.building.value?.isActive ?? false)
                  ? 'ใช้งาน'
                  : 'ไม่ใช้งาน',
              valueColor: (controller.building.value?.isActive ?? false)
                  ? Colors.green
                  : Colors.red,
            ),
            if (controller.building.value?.latitude != 0)
              InfoRowComponent(
                icon: Icons.map,
                label: 'พิกัด',
                value:
                    '${controller.building.value?.latitude}, ${controller.building.value?.longitude}',
              ),
          ],
        ),
      ],
    );
  }
}

class _RoomsTab extends GetView<PanelController> {
  final ThemeData theme;
  const _RoomsTab({required this.theme});

  @override
  Widget build(BuildContext context) {
    if (controller.building.value!.rooms.isEmpty) {
      return const NotComponent(
        icon: Icons.meeting_room,
        label: 'ไม่มีข้อมูลห้อง',
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.building.value?.rooms.length,
      itemBuilder: (context, index) {
        final room = controller.building.value?.rooms[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            onTap: () => Get.toNamed(Routes.public.room, arguments: room?.id),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Text(
                room?.roomNumber ?? '-',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            title: Text(
              room?.roomName ?? '-',
              style: theme.textTheme.titleMedium,
            ),
            subtitle: Text('ชั้น: ${room?.floor ?? '-'}'),
          ),
        );
      },
    );
  }
}

class _DepartmentsTab extends GetView<PanelController> {
  final ThemeData theme;
  const _DepartmentsTab({required this.theme});

  @override
  Widget build(BuildContext context) {
    if (controller.building.value!.departments.isEmpty) {
      return const NotComponent(icon: Icons.business, label: 'ไม่มีข้อมูลแผนก');
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.building.value?.departments.length,
      itemBuilder: (context, index) {
        final dept = controller.building.value?.departments[index];
        return InfoSectionComponent(
          logo: dept?.image,
          title: dept?.title ?? '-',
          members: (dept?.members ?? [])
              .map((m) => InfoMemberComponent(member: m))
              .toList(),
        );
      },
    );
  }
}

class _WorksTap extends GetView<PanelController> {
  final ThemeData theme;
  const _WorksTap({required this.theme});

  @override
  Widget build(BuildContext context) {
    if (controller.building.value!.works.isEmpty) {
      return const NotComponent(
        icon: Icons.work_outline,
        label: 'ไม่มีข้อมูลงาน',
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.building.value?.works.length,
      itemBuilder: (context, index) {
        final work = controller.building.value?.works[index];
        return InfoSectionComponent(
          logo: work?.image,
          title: work?.title ?? '-',
          members: (work?.members ?? [])
              .map((m) => InfoMemberComponent(member: m))
              .toList(),
        );
      },
    );
  }
}
