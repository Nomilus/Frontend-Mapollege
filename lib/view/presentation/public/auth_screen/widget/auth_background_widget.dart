import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/presentation/public/auth_screen/controller/auth_controller.dart';

class AuthBackgroundWidget extends GetView<AuthController> {
  const AuthBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: -100,
          left: -100,
          child:
              Container(
                    width: 500,
                    height: 500,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          theme.colorScheme.primary.withValues(alpha: 0.9),
                          theme.colorScheme.primaryContainer.withValues(
                            alpha: 0.1,
                          ),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .move(
                    begin: const Offset(-20, -20),
                    end: const Offset(40, 40),
                    duration: NumDurationExtensions(6).seconds,
                    curve: Curves.easeInOut,
                  )
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.2, 1.2),
                    duration: NumDurationExtensions(4).seconds,
                  ),
        ),
        Positioned(
          right: -150,
          top: 100,
          child:
              Container(
                    width: 600,
                    height: 600,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          theme.colorScheme.secondary.withValues(alpha: 0.9),
                          theme.colorScheme.secondaryContainer.withValues(
                            alpha: 0.1,
                          ),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .move(
                    begin: const Offset(30, 0),
                    end: const Offset(-30, 80),
                    duration: NumDurationExtensions(8).seconds,
                    curve: Curves.easeInOut,
                  )
                  .blur(begin: const Offset(10, 10), end: const Offset(30, 30)),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.colorScheme.surface.withValues(alpha: 0.2),
                  theme.colorScheme.surface,
                ],
                stops: const [0.0, 0.9],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: const SizedBox.expand(),
          ),
        ),
      ],
    );
  }
}
