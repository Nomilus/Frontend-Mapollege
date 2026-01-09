import 'package:application_mapollege/config/router/routes.dart';
import 'package:application_mapollege/view/components/search_component.dart';
import 'package:application_mapollege/view/presentation/public/home_screen/controller/home_controller.dart';
import 'package:application_mapollege/view/presentation/public/home_screen/controller/map_controller.dart';
import 'package:application_mapollege/view/presentation/public/home_screen/widget/panel_widget.dart';
import 'package:application_mapollege/view/presentation/public/home_screen/widget/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  final MapController mapController = Get.find<MapController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      resizeToAvoidBottomInset: false,
      body: _buildContent(MediaQuery.of(context).padding.top, theme),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFloatingButton(theme),
      bottomNavigationBar: _buildBottomAppBar(theme),
    );
  }

  Widget _buildContent(double top, ThemeData theme) {
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
        SafeArea(
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 8,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    const Expanded(child: SearchComponents()),
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
                        padding: const WidgetStatePropertyAll(
                          EdgeInsets.all(2),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          theme.colorScheme.surfaceContainer,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: Text(
                          'ดาวเทียม',
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      Obx(() {
                        return Switch(
                          value: mapController.isSatellite.value,
                          onChanged: mapController.toggleMapType,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        );
                      }),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.refreshController?.forward(from: 0);
                  },
                  icon: const Icon(Icons.refresh)
                      .animate(
                        autoPlay: false,
                        onInit: (control) =>
                            controller.refreshController = control,
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
              ],
            ),
          ),
        ),
        const PanelWidget(),
      ],
    );
  }

  Widget _buildFloatingButton(ThemeData theme) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: theme.colorScheme.primaryContainer,
                onPressed: () => Get.toNamed(Routes.public.scanner),
                heroTag: 'qrcode',
                icon: Icon(
                  Icons.qr_code_scanner,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                label: Text(
                  'Scanner',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            foregroundColor: theme.colorScheme.inverseSurface,
            backgroundColor: theme.colorScheme.surfaceContainerHigh,
            onPressed: mapController.moveToSelfLocation,
            heroTag: 'location',
            child: const Icon(Icons.my_location_rounded),
          ),
          const Expanded(flex: 3, child: SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildBottomAppBar(ThemeData theme) {
    return BottomAppBar(
      notchMargin: 0.0,
      height: 60,
      child: Row(
        children: [
          const Expanded(flex: 3, child: SizedBox.shrink()),
          Expanded(
            flex: 1,
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
    );
  }
}
