import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShimmerComponent extends StatelessWidget {
  final Widget child;

  const ShimmerComponent({super.key, required this.child});

  static ShimmerLayout layout(BuildContext context) {
    return ShimmerLayout(context);
  }

  @override
  Widget build(BuildContext context) => child
      .animate(onPlay: (controller) => controller.repeat())
      .shimmer(
        duration: 1200.ms,
        blendMode: BlendMode.srcATop,
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
      );
}

class ShimmerLayout {
  final BuildContext context;

  const ShimmerLayout(this.context);

  Widget nested([double? headHeight]) {
    final theme = Theme.of(context);
    final baseColor = theme.colorScheme.surfaceContainer;

    return Column(
          children: [
            Container(
              width: double.infinity,
              height: headHeight ?? 300,
              decoration: BoxDecoration(color: baseColor),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: 1200.ms,
          blendMode: BlendMode.srcATop,
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
        );
  }
}
