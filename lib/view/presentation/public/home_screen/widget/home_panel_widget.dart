import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mapollege/config/router/routes.dart';
import 'package:mapollege/view/components/delegate_component.dart';
import 'package:mapollege/view/components/image_component.dart';
import 'package:mapollege/view/components/info_component.dart';
import 'package:mapollege/view/components/not_component.dart';
import 'package:mapollege/view/components/shimmer_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/widget_controller/panel_widget_controller.dart';

class PanelWidget extends GetView<PanelWidgetController> {
  const PanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final building = controller.building.value;

    controller.tabs.assignAll([
      const Tab(text: 'ข้อมูลอาคาร'),
      if (building?.rooms.isNotEmpty == true)
        Tab(text: 'ห้อง (${building!.rooms.length})'),
      if (building?.departments.isNotEmpty == true)
        Tab(text: 'แผนก (${building!.departments.length})'),
      if (building?.works.isNotEmpty == true)
        Tab(text: 'งาน (${building!.works.length})'),
    ]);

    controller.tabViews.assignAll([
      _BuildingTab(theme: theme),
      if (building?.rooms.isNotEmpty == true) _RoomsTab(theme: theme),
      if (building?.departments.isNotEmpty == true)
        _DepartmentsTab(theme: theme),
      if (building?.works.isNotEmpty == true) _WorksTap(theme: theme),
    ]);

    return SlidingUpPanelWidget(
      controlHeight: 36.0,
      anchor: 0.4,
      panelController: controller.panelController,
      enableOnTap: false,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: DefaultTabController(
          length: controller.tabs.length,
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
              Obx(() {
                final building = controller.building.value;

                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text('อาคาร', style: theme.textTheme.titleMedium),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    if (building != null)
                      IconButton(
                        onPressed: () =>
                            controller.linePolylinePoints(building),
                        icon: const FaIcon(Icons.directions_run_rounded),
                      ),
                    if (building != null)
                      IconButton(
                        onPressed: () {},
                        icon: const FaIcon(Icons.qr_code),
                      ),
                    IconButton(
                      onPressed: () => controller.panelController.collapse(),
                      icon: const FaIcon(FontAwesomeIcons.xmark),
                    ),
                  ],
                );
              }),
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

class _BuildingContent extends GetView<PanelWidgetController> {
  final ThemeData theme;
  const _BuildingContent({required this.theme});

  @override
  Widget build(BuildContext context) {
    final building = controller.building.value;

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
                building?.name ?? '-',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge,
              ),
            ),
            background: ImageComponent(images: building?.images ?? []),
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
              tabs: controller.tabs.toList(),
            ),
          ),
        ),
      ],
      body: TabBarView(children: controller.tabViews.toList()),
    );
  }
}

class _BuildingTab extends GetView<PanelWidgetController> {
  final ThemeData theme;
  const _BuildingTab({required this.theme});

  @override
  Widget build(BuildContext context) {
    final building = controller.building.value;

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
                value: building?.description,
              ),
            InfoRowComponent(
              icon: Icons.location_on,
              label: 'ที่อยู่',
              value: building?.address,
            ),
            InfoRowComponent(
              icon: Icons.layers,
              label: 'จำนวนชั้น',
              value: '${building?.floorCount} ชั้น',
            ),
            InfoRowComponent(
              icon: (building?.isActive ?? false)
                  ? Icons.check_circle
                  : Icons.unpublished,
              label: 'สถานะ',
              value: (building?.isActive ?? false) ? 'ใช้งาน' : 'ไม่ใช้งาน',
              valueColor: (building?.isActive ?? false)
                  ? Colors.green
                  : Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}

class _RoomsTab extends GetView<PanelWidgetController> {
  final ThemeData theme;
  const _RoomsTab({required this.theme});

  @override
  Widget build(BuildContext context) {
    final building = controller.building.value;

    if (building == null) {
      return const NotComponent(
        icon: Icons.meeting_room,
        label: 'ไม่มีข้อมูลห้อง',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: building.rooms.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final room = building.rooms[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: theme.colorScheme.surfaceContainerHigh,
            ),
            color: theme.colorScheme.surfaceContainer,
          ),
          child: Material(
            color: Colors.transparent,
            child: ListTile(
              onTap: () => Get.toNamed(Routes.public.room, arguments: room.id),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(room.title, style: theme.textTheme.titleMedium),
              subtitle: Text(
                'ชั้น: ${room.floor}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DepartmentsTab extends GetView<PanelWidgetController> {
  final ThemeData theme;
  const _DepartmentsTab({required this.theme});

  @override
  Widget build(BuildContext context) {
    final building = controller.building.value;

    if (building == null) {
      return const NotComponent(icon: Icons.business, label: 'ไม่มีข้อมูลแผนก');
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: building.departments.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final dept = building.departments[index];
        return InfoSectionComponent(
          logo: dept.image,
          title: dept.title,
          members: (dept.members)
              .map((m) => InfoMemberComponent(member: m))
              .toList(),
        );
      },
    );
  }
}

class _WorksTap extends GetView<PanelWidgetController> {
  final ThemeData theme;
  const _WorksTap({required this.theme});

  @override
  Widget build(BuildContext context) {
    final building = controller.building.value;

    if (building == null) {
      return const NotComponent(
        icon: Icons.work_outline,
        label: 'ไม่มีข้อมูลงาน',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: building.works.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final work = building.works[index];
        return InfoSectionComponent(
          logo: work.image,
          title: work.title,
          members: (work.members)
              .map((m) => InfoMemberComponent(member: m))
              .toList(),
        );
      },
    );
  }
}
