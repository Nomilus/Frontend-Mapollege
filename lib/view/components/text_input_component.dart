import 'package:flutter/material.dart';

class TextInputComponent extends StatefulWidget {
  const TextInputComponent({
    super.key,
    required this.control,
    this.maxLength,
    this.label,
    this.hint,
    this.icon,
    this.tip,
    this.validator,
  });

  final TextEditingController control;
  final int maxLines = 1;
  final bool passwordMode = false;
  final int? maxLength;
  final String? label;
  final String? hint;
  final Icon? icon;
  final String? tip;
  final String? Function(String?)? validator;

  @override
  State<TextInputComponent> createState() => _TextInputComponentState();
}

class _TextInputComponentState extends State<TextInputComponent> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        Visibility(
          visible: widget.label != null || widget.tip != null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 2,
            children: [
              Visibility(
                visible: widget.label != null,
                child: Text(
                  widget.label ?? '',
                  style: theme.textTheme.titleSmall,
                ),
              ),
              Visibility(
                visible: widget.tip != null,
                child: Tooltip(
                  message: widget.tip ?? '',
                  child: Icon(
                    Icons.info_outline,
                    size: theme.textTheme.bodyLarge!.fontSize,
                  ),
                ),
              ),
            ],
          ),
        ),
        TextFormField(
          controller: widget.control,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          validator: widget.validator,
          obscureText: _showPassword,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.colorScheme.surfaceContainer,
            prefixIcon: widget.icon,
            suffixIcon: widget.passwordMode
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: Icon(
                      _showPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  )
                : widget.maxLines == 1
                ? ValueListenableBuilder<TextEditingValue>(
                    valueListenable: widget.control,
                    builder: (context, value, child) {
                      if (value.text.isNotEmpty) {
                        return IconButton(
                          onPressed: widget.control.clear,
                          icon: const Icon(Icons.close),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  )
                : null,
            hintText: widget.hint,
            hintStyle: theme.textTheme.bodyMedium!.apply(color: Colors.grey),
            border: theme.inputDecorationTheme.border,
            focusedBorder: theme.inputDecorationTheme.focusedBorder,
            enabledBorder: theme.inputDecorationTheme.enabledBorder,
            disabledBorder: theme.inputDecorationTheme.disabledBorder,
            errorBorder: theme.inputDecorationTheme.errorBorder,
            focusedErrorBorder: theme.inputDecorationTheme.focusedErrorBorder,
          ),
        ),
      ],
    );
  }
}
