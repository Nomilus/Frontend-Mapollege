import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/components/not_component.dart';
import 'package:mapollege/view/components/shimmer_component.dart';
import 'package:mapollege/view/presentation/public/search_screen/controller/search_controller.dart';
import 'package:mapollege/view/presentation/public/search_screen/widget/search_item_widget.dart';

class SearchListWidget extends GetView<SearchGetController> {
  const SearchListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return _buildLoaning(context);
      }

      if (controller.listResult.isEmpty) {
        return SliverFillRemaining(
          child: Center(
            child: NotComponent(
              icon: controller.searchQuery.value.isEmpty
                  ? FontAwesomeIcons.solidBellSlash
                  : FontAwesomeIcons.ban,
              label: controller.searchQuery.value.isEmpty
                  ? 'ไม่มีรายการ'
                  : 'ไม่พบผลลัพธ์',
            ),
          ),
        );
      }

      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList.separated(
          itemCount: controller.listResult.length,
          itemBuilder: (context, index) =>
              SearchItemWidget(model: controller.listResult[index]),
          separatorBuilder: (_, __) => const SizedBox(height: 8),
        ),
      );
    });
  }

  SliverPadding _buildLoaning(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: ShimmerComponent(
          child: Column(
            spacing: 8,
            children: List.generate(
              6,
              (index) => Container(
                width: double.infinity,
                height: 64,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
