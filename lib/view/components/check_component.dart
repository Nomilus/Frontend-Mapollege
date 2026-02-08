import 'package:flutter/material.dart';

class CheckComponent extends StatelessWidget {
  const CheckComponent({
    super.key,
    required this.value,
    this.onChanged,
    this.title,
    this.subtitle,
  });

  final bool value;
  final void Function(bool?)? onChanged;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      title: title != null
          ? Text(
              title!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: value
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
              ),
            )
          : null,
      subtitle: subtitle != null
          ? Text(subtitle!, style: theme.textTheme.bodySmall)
          : null,
      activeColor: theme.colorScheme.primary,
      checkColor: theme.colorScheme.onPrimary,
      controlAffinity: ListTileControlAffinity.trailing,
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
