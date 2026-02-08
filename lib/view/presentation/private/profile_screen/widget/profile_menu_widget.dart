import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/components/menu_component.dart';
import 'package:mapollege/view/presentation/private/profile_screen/controller/profile_controller.dart';

class ProfileMenuWidget extends GetView<ProfileController> {
  const ProfileMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return MenuCardComponent(
      title: Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 2),
        child: Text('ตั้งค่าทั่วไป', style: theme.textTheme.bodySmall),
      ),
      borderRadius: const Radius.circular(16),
      spacing: 8,
      items: [
        MenuRowComponent(
          icon: Icons.dark_mode_outlined,
          title: 'โหมดกลางคืน',
          backgroundColor: theme.colorScheme.surfaceContainer,
          borderColor: theme.colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(5),
          trailing: Obx(
            () => Switch(
              padding: EdgeInsets.zero,
              value: controller.isTheme,
              onChanged: (value) => controller.toggleTheme,
            ),
          ),
        ),
        MenuRowComponent(
          icon: Icons.logout,
          title: 'ออกจากระบบ',
          backgroundColor: theme.colorScheme.errorContainer,
          borderColor: theme.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(5),
          titleColor: theme.colorScheme.onErrorContainer,
          iconColor: theme.colorScheme.onErrorContainer,
          onTap: () => controller.signOut(),
        ),
      ],
    );
  }
}
