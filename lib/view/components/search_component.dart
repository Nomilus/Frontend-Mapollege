import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchComponents extends StatelessWidget {
  const SearchComponents({
    super.key,
    this.controller,
    this.onChanged,
    this.title = 'ค้นหา...',
  });

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? title;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SearchBar(
      controller: controller,
      textInputAction: TextInputAction.done,
      constraints: const BoxConstraints(minHeight: 48),
      hintText: title,
      side: WidgetStatePropertyAll(
        BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      leading: const Padding(
        padding: EdgeInsets.only(left: 8),
        child: FaIcon(FontAwesomeIcons.magnifyingGlass, size: 18),
      ),
      trailing: [
        ValueListenableBuilder(
          valueListenable: controller ?? TextEditingController(),
          builder: (context, value, child) {
            return Visibility(
              visible: value.text.isNotEmpty,
              child: IconButton(
                icon: const FaIcon(FontAwesomeIcons.xmark, size: 16),
                onPressed: () {
                  controller?.clear();
                  if (onChanged != null) onChanged!("");
                },
              ),
            );
          },
        ),
      ],
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      onChanged: onChanged,
      elevation: const WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(
        theme.colorScheme.surfaceContainer,
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
