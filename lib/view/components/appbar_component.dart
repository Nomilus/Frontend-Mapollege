import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AppbarComponent {
  PreferredSizeWidget box({
    required String title,
    List<Widget>? actions,
    VoidCallback? onPressed,
  }) => Box(title: title, actions: actions, onPressed: onPressed);
  Widget sliver({
    required String title,
    bool floating = false,
    bool pinned = false,
    bool snap = false,
    List<Widget>? actions,
    VoidCallback? onPressed,
  }) => Sliver(
    title: title,
    floating: floating,
    pinned: pinned,
    snap: snap,
    actions: actions,
    onPressed: onPressed,
  );
}

class Box extends StatelessWidget implements PreferredSizeWidget {
  const Box({
    super.key,
    required this.title,
    required this.actions,
    required this.onPressed,
  });

  final String title;
  final List<Widget>? actions;
  final VoidCallback? onPressed;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: theme.colorScheme.surface.withValues(alpha: 0),
      backgroundColor: theme.colorScheme.surface.withValues(alpha: 0),
      title: Row(
        spacing: 8,
        children: [
          IconButton(
            onPressed: onPressed ?? () => Get.back(),
            icon: const FaIcon(FontAwesomeIcons.angleLeft),
          ),
          Text(title),
        ],
      ),
      actions: actions,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surface.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}

class Sliver extends StatelessWidget {
  const Sliver({
    super.key,
    required this.title,
    required this.floating,
    required this.pinned,
    required this.snap,
    required this.actions,
    required this.onPressed,
  });

  final String title;
  final bool floating;
  final bool pinned;
  final bool snap;
  final List<Widget>? actions;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SliverAppBar(
      floating: floating,
      pinned: pinned,
      snap: snap,
      automaticallyImplyLeading: false,
      surfaceTintColor: theme.colorScheme.surface.withValues(alpha: 0),
      backgroundColor: theme.colorScheme.surface.withValues(alpha: 0),
      title: Row(
        spacing: 8,
        children: [
          IconButton(
            onPressed: onPressed ?? () => Get.back(),
            icon: const FaIcon(FontAwesomeIcons.angleLeft),
          ),
          Text(title),
        ],
      ),
      actions: actions,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surface.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}
