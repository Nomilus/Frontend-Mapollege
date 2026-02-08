import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapollege/core/utility/toast_utility.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/layout_controller/main_layout_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:mapollege/config/router/routes.dart';
import 'package:mapollege/view/components/search_component.dart';
import 'package:mapollege/view/presentation/public/home_screen/widget/home_map_widget.dart';
import 'package:mapollege/view/presentation/public/home_screen/widget/home_panel_widget.dart';

class MainLayout extends GetView<MainLayoutController> {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final control = controller.panelWidgetController.panelController;

        if (control.value == SlidingUpPanelStatus.expanded ||
            control.value == SlidingUpPanelStatus.anchored) {
          control.collapse();
          return;
        }

        final now = DateTime.now();
        final isWarningStage =
            controller.lastPressed == null ||
            now.difference(controller.lastPressed!) >
                const Duration(seconds: 2);

        if (isWarningStage) {
          controller.lastPressed = now;
          ToastUtility.show(msg: "กดอีกครั้งเพื่อออกจากแอป");
        } else {
          SystemNavigator.pop();
        }
      },
      child: _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends GetView<MainLayoutController> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double top = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        const Positioned.fill(child: MapWidget()),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: top,
            color: theme.colorScheme.surface.withValues(alpha: 0.5),
          ),
        ),
        _buildHeader(context),
        const PanelWidget(),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Expanded(child: _buildSearch(context)),
            _buildTools(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchComponents(
          controller: controller.searchController,
          title: 'ค้นหา',
          onChanged: (value) => controller.onSearchChanged(value),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Visibility(
            visible: controller.searchResponse.isNotEmpty,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer.withValues(
                  alpha: 0.8,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: controller.searchResponse
                    .map(
                      (s) => Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () => controller.onSearchClick(s.id),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Text(s.name),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTools(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        IconButton(
          onPressed: () => Get.toNamed(Routes.private.profile),
          icon: Obx(() {
            final user = controller.currentUser;

            return CircleAvatar(
              foregroundImage: (user != null)
                  ? NetworkImage(user.picture)
                  : null,
              child: const Icon(Icons.person),
            );
          }),
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(EdgeInsets.all(2)),
            backgroundColor: WidgetStatePropertyAll(
              theme.colorScheme.surfaceContainer,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            controller.refreshController?.forward(from: 0);
            controller.mapWidgetController.rotateCamera();
          },
          icon: const Icon(Icons.refresh)
              .animate(
                autoPlay: false,
                onInit: (control) => controller.refreshController = control,
              )
              .rotate(
                duration: 600.ms,
                begin: 0,
                end: 1,
                curve: Curves.easeInOut,
              ),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              theme.colorScheme.surfaceContainer,
            ),
            shadowColor: const WidgetStatePropertyAll(Colors.black),
            elevation: const WidgetStatePropertyAll(2),
          ),
        ),
        IconButton(
          onPressed: () => controller.mapWidgetController.moveToLocation(
            const LatLng(15.241698067868498, 104.8454945672114),
            16,
          ),
          icon: const Icon(Icons.corporate_fare),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              theme.colorScheme.surfaceContainer,
            ),
            shadowColor: const WidgetStatePropertyAll(Colors.black),
            elevation: const WidgetStatePropertyAll(2),
          ),
        ),
      ],
    );
  }
}
