import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/home_controller.dart';

class HomeFloatingWidget extends GetView<HomeController> {
  const HomeFloatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Obx(() {
                final index = controller.currentIndex.value;
                final isActive = (index == 1) ? true : false;

                return FloatingActionButton.extended(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      width: 1,
                      color: theme.colorScheme.surfaceContainerHighest,
                    ),
                  ),
                  backgroundColor: isActive
                      ? theme.colorScheme.surfaceContainerHigh
                      : theme.colorScheme.primaryContainer,

                  onPressed: () {
                    if (controller.currentIndex.value != 1) {
                      controller.changePage(1);
                    } else {
                      controller.changePage(0);
                    }
                  },
                  heroTag: 'qrcode',
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: Icon(
                      isActive ? Icons.close : Icons.qr_code_scanner,
                      key: ValueKey<bool>(isActive),
                      color: isActive
                          ? theme.colorScheme.inverseSurface
                          : theme.colorScheme.onPrimaryContainer,
                    ),
                  ),

                  label: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: isActive
                          ? theme.colorScheme.inverseSurface
                          : theme.colorScheme.onPrimaryContainer,
                    ),
                    child: Text(isActive ? 'ปิด' : 'สแกน'),
                  ),
                );
              }),
            ),
          ),
          FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                width: 1,
                color: theme.colorScheme.surfaceContainerHighest,
              ),
            ),
            foregroundColor: theme.colorScheme.inverseSurface,
            backgroundColor: theme.colorScheme.surfaceContainerHigh,
            onPressed: () {
              if (controller.currentIndex.value != 0) {
                controller.changePage(0);
              }
              controller.mapWidgetController.moveToSelfLocation();
            },
            heroTag: 'location',
            child: const Icon(Icons.my_location_rounded),
          ),
          const Expanded(flex: 3, child: SizedBox.shrink()),
        ],
      ),
    );
  }
}
