import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mapollege/core/enum/direction_enum.dart';
import 'package:mapollege/core/enum/table_enum.dart';
import 'package:mapollege/view/components/radio_component.dart';
import 'package:mapollege/view/presentation/public/search_screen/controller/search_controller.dart';

class SearchDrawerWidget extends GetView<SearchGetController> {
  const SearchDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Container(
        width: mediaQuery.size.width / 1.5,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListView(
            children: [
              Obx(
                () => _buildGroupItem(
                  context,
                  title: 'ประเภทการค้นหา',
                  icon: Icons.category_outlined,
                  items: [
                    RadioComponent<TableEnum>(
                      title: 'อาคาร',
                      value: TableEnum.building,
                      onChanged: (value) => controller.onTableChanged(value),
                      groupValue: controller.tableSelected.value,
                    ),
                    RadioComponent<TableEnum>(
                      title: 'ห้อง',
                      value: TableEnum.room,
                      onChanged: (value) => controller.onTableChanged(value),
                      groupValue: controller.tableSelected.value,
                    ),
                    RadioComponent<TableEnum>(
                      title: 'บุคลากร',
                      value: TableEnum.person,
                      onChanged: (value) => controller.onTableChanged(value),
                      groupValue: controller.tableSelected.value,
                    ),
                    RadioComponent<TableEnum>(
                      title: 'แผนก',
                      value: TableEnum.department,
                      onChanged: (value) => controller.onTableChanged(value),
                      groupValue: controller.tableSelected.value,
                    ),
                    RadioComponent<TableEnum>(
                      title: 'งาน',
                      value: TableEnum.work,
                      onChanged: (value) => controller.onTableChanged(value),
                      groupValue: controller.tableSelected.value,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => _buildGroupItem(
                  context,
                  title: 'ลำดับการแสดงผล',
                  icon: Icons.sort_by_alpha,
                  items: [
                    RadioComponent<DirectionEnum>(
                      title: 'A-Z',
                      value: DirectionEnum.asc,
                      onChanged: (value) =>
                          controller.onDirectionChanged(value),
                      groupValue: controller.directionSelected.value,
                    ),
                    RadioComponent<DirectionEnum>(
                      title: 'Z-A',
                      value: DirectionEnum.desc,
                      onChanged: (value) =>
                          controller.onDirectionChanged(value),
                      groupValue: controller.directionSelected.value,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => _buildGroupItem(
                  context,
                  title: 'จำนวนรายการต่อหน้า',
                  icon: Icons.format_list_numbered_rounded,
                  items: [
                    RadioComponent<int>(
                      title: '10 รายการ',
                      value: 10,
                      onChanged: (value) => controller.onPageSizeChanged(value),
                      groupValue: controller.pageSizeSelected.value,
                    ),
                    RadioComponent<int>(
                      title: '20 รายการ',
                      value: 20,
                      onChanged: (value) => controller.onPageSizeChanged(value),
                      groupValue: controller.pageSizeSelected.value,
                    ),
                    RadioComponent<int>(
                      title: '50 รายการ',
                      value: 50,
                      onChanged: (value) => controller.onPageSizeChanged(value),
                      groupValue: controller.pageSizeSelected.value,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupItem(
    BuildContext context, {
    required String title,
    IconData? icon,
    List<Widget>? items,
  }) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              FaIcon(icon, size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
            ],
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (items != null) ...items.map((item) => item),
        const SizedBox(height: 8),
        Divider(color: theme.colorScheme.outlineVariant),
      ],
    );
  }
}
