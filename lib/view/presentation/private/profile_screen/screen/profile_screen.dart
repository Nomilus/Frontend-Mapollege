import 'package:application_mapollege/config/router/routes.dart';
import 'package:application_mapollege/core/model/people/user_model.dart';
import 'package:application_mapollege/view/components/not_component.dart';
import 'package:application_mapollege/view/components/shimmer_component.dart';
import 'package:application_mapollege/view/presentation/private/profile_screen/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: AppBar(
          title: Text('โปรไฟล์', style: theme.textTheme.titleLarge),
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(Routes.private.notification),
              icon: const Icon(Icons.notifications),
            ),
          ],
          shape: Border(
            bottom: BorderSide(
              width: 1,
              color: theme.colorScheme.outlineVariant,
            ),
          ),
        ),
        body: SafeArea(
          child: Obx(() {
            if (controller.isLoading.value) {
              return ShimmerComponent(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    spacing: 8,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 3,
                        ),
                        width: double.infinity,
                        height: 225,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 3,
                        ),
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final user = controller.currentUser;
            if (user == null) {
              return const NotComponent(
                icon: Icons.person_off,
                label: 'ไม่พบข้อมูลผู้ใช้',
              );
            }

            return _buildContent(theme, user);
          }),
        ),
      ),
    );
  }

  Widget _buildContent(ThemeData theme, UserModel user) {
    return RefreshIndicator(
      onRefresh: () => controller.refreshUser(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileHeader(theme, user),
          const SizedBox(height: 8),
          _buildMenuSection(theme),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme, UserModel user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          spacing: 8,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: theme.colorScheme.primaryContainer,
              backgroundImage: NetworkImage(user.picture),
            ),
            Text(
              user.name,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              user.email,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                user.role.name,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          children: [
            _buildMenuItem(
              theme,
              icon: Icons.dark_mode_outlined,
              title: 'โหมดกลางคืน',
              backgroundColor: theme.colorScheme.surfaceContainerHigh,
              trailing: Obx(
                () => Switch(
                  padding: EdgeInsets.zero,
                  value: controller.isTheme,
                  onChanged: (value) => controller.toggleTheme,
                ),
              ),
            ),
            _buildMenuItem(
              theme,
              icon: Icons.logout,
              title: 'ออกจากระบบ',
              backgroundColor: theme.colorScheme.errorContainer,
              textColor: theme.colorScheme.onErrorContainer,
              iconColor: theme.colorScheme.onErrorContainer,
              onTap: () => controller.signOut(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    ThemeData theme, {
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(100),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onTap: onTap,
        leading: Icon(icon, color: iconColor ?? theme.colorScheme.onSurface),
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: textColor ?? theme.colorScheme.onSurface,
          ),
        ),
        trailing:
            trailing ?? Icon(Icons.chevron_right, size: 20, color: iconColor),
      ),
    );
  }
}
