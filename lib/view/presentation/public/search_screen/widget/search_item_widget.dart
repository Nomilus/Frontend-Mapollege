import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapollege/core/model/mix_model.dart';
import 'package:mapollege/view/presentation/public/search_screen/controller/search_controller.dart';

class SearchItemWidget<T extends MixModel>
    extends GetView<SearchGetController> {
  const SearchItemWidget({super.key, required this.model});

  final T model;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller.showMore(model),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: Text(
                    model.title,
                    style: theme.textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                  color: theme.colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
