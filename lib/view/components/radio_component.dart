import 'package:flutter/material.dart';

class RadioComponent<T> extends StatelessWidget {
  const RadioComponent({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
    this.subtitle,
  });

  final T value;
  final T groupValue;
  final void Function(T?)? onChanged;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return RadioListTile<T>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      title: title != null
          ? Text(title!, style: theme.textTheme.bodyMedium)
          : null,
      subtitle: subtitle != null
          ? Text(subtitle!, style: theme.textTheme.bodySmall)
          : null,
      activeColor: theme.colorScheme.primary,
      controlAffinity: ListTileControlAffinity.trailing,
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
