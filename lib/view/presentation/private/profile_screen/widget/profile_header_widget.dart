import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/components/not_component.dart';
import 'package:mapollege/view/presentation/private/profile_screen/controller/profile_controller.dart';

class ProfileHeaderWidget extends GetView<ProfileController> {
  const ProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final user = controller.currentUser;
    if (user == null) {
      return const NotComponent(
        icon: Icons.person_off,
        label: 'ไม่พบข้อมูลผู้ใช้',
      );
    }

    return Column(
      spacing: 4,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: theme.colorScheme.primaryContainer,
          backgroundImage: NetworkImage(user.picture),
        ),
        Text(user.name, style: theme.textTheme.headlineSmall?.copyWith()),
        Text(
          user.email,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            user.role.name,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
