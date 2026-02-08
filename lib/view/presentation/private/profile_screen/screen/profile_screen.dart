import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/components/appbar_component.dart';
import 'package:mapollege/view/components/shimmer_component.dart';
import 'package:mapollege/view/presentation/private/profile_screen/controller/profile_controller.dart';
import 'package:mapollege/view/presentation/private/profile_screen/widget/profile_header_widget.dart';
import 'package:mapollege/view/presentation/private/profile_screen/widget/profile_menu_widget.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.refreshUser(),
          child: SafeArea(child: _ProfileScreenContent()),
        ),
      ),
    );
  }
}

class _ProfileScreenContent extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        AppbarComponent().sliver(title: 'โปรไฟล์'),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverFillRemaining(
            child: Obx(() {
              if (controller.isLoading.value) {
                return _buildLoaning(context);
              }

              return const Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [ProfileHeaderWidget(), ProfileMenuWidget()],
              );
            }),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }

  Widget _buildLoaning(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return ShimmerComponent(
      child: Column(
        spacing: 8,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ],
      ),
    );
  }
}
