import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mapollege/config/router/routes.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/home_controller.dart';

class HomeNavigationWidget extends GetView<HomeController> {
  const HomeNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: theme.colorScheme.surfaceContainerHigh,
          ),
        ),
      ),
      child: BottomAppBar(
        elevation: 0,
        notchMargin: 0.0,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 60,
        child: Row(
          spacing: 8,
          children: [
            const Expanded(flex: 3, child: SizedBox.shrink()),
            Expanded(
              flex: 1,
              child: _buildNavItem(
                context,
                icon: FontAwesomeIcons.magnifyingGlass,
                label: 'ค้นหา',
                onTap: () => Get.toNamed(Routes.public.search),
              ),
            ),
            Expanded(
              flex: 1,
              child: _buildNavItem(
                context,
                icon: FontAwesomeIcons.solidBell,
                label: 'แจ้งเตือน',
                onTap: () => Get.toNamed(Routes.public.notification),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  icon,
                  size: 20,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
