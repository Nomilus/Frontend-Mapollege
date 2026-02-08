import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuCardComponent extends StatelessWidget {
  const MenuCardComponent({
    super.key,
    required this.items,
    this.title,
    this.spacing,
    this.borderRadius,
  });

  final List<MenuRowComponent> items;
  final Widget? title;
  final double? spacing;
  final Radius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ?title,
        Column(
          spacing: spacing ?? 0,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(items.length, (index) {
            if (index == 0) {
              return items[index].customBorderRadius(
                topLeft: borderRadius,
                topRight: borderRadius,
              );
            }
            if (index == items.length - 1) {
              return items[index].customBorderRadius(
                bottomLeft: borderRadius,
                bottomRight: borderRadius,
              );
            }
            return items[index];
          }),
        ),
      ],
    );
  }
}

class MenuRowComponent extends StatelessWidget {
  const MenuRowComponent({
    super.key,
    required this.icon,
    required this.title,
    this.borderRadius,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.titleColor,
    this.subtitleColor,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? iconColor;

  MenuRowComponent customBorderRadius({
    Radius? topLeft,
    Radius? topRight,
    Radius? bottomLeft,
    Radius? bottomRight,
  }) {
    final customBorderRadius = BorderRadius.only(
      topLeft: topLeft ?? borderRadius?.topLeft ?? Radius.zero,
      topRight: topRight ?? borderRadius?.topRight ?? Radius.zero,
      bottomLeft: bottomLeft ?? borderRadius?.bottomLeft ?? Radius.zero,
      bottomRight: bottomRight ?? borderRadius?.bottomRight ?? Radius.zero,
    );

    return MenuRowComponent(
      icon: icon,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      borderRadius: customBorderRadius,
      onTap: onTap,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      titleColor: titleColor,
      subtitleColor: subtitleColor,
      iconColor: iconColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(minHeight: 50),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.surfaceContainer,
        borderRadius: borderRadius,
        border: Border.all(
          width: 1,
          color: borderColor ?? theme.colorScheme.surfaceContainerHigh,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              spacing: 8,
              children: [
                FaIcon(icon, color: iconColor ?? theme.colorScheme.onSurface),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: titleColor ?? theme.colorScheme.onSurface,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        title,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: subtitleColor ?? theme.colorScheme.onSurface,
                        ),
                      ),
                  ],
                ),
                const Expanded(child: SizedBox.shrink()),
                trailing ??
                    FaIcon(Icons.chevron_right, size: 20, color: iconColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
