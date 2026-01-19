import 'dart:ui';

import 'package:mapollege/config/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/presentation/public/auth_screen/controller/auth_controller.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(child: _buildBackground(theme)),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(child: _TitleContent()),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: IconButton(
                  onPressed: () => controller.toggleTheme,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      theme.colorScheme.surfaceContainer,
                    ),
                    shadowColor: const WidgetStatePropertyAll(Colors.black),
                    elevation: const WidgetStatePropertyAll(2),
                  ),
                  icon: controller.isTheme
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(ThemeData theme) {
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

class _TitleContent extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Row(
            spacing: 8,
            children: [
              const Icon(Icons.location_on),
              Text('Mapollege', style: theme.textTheme.titleSmall),
            ],
          ),
          Text(
            'This is Testing Title App',
            style: theme.textTheme.displayLarge,
          ),
          Text('details', style: theme.textTheme.bodySmall),
          const SizedBox(height: 8),
          _buildSignInWithGoogleButton(theme),
          _buildSkipButton(theme),
        ],
      ),
    );
  }

  Widget _buildSignInWithGoogleButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controller.signIn(),
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          backgroundColor: WidgetStatePropertyAll(theme.colorScheme.onSurface),
          foregroundColor: WidgetStatePropertyAll(theme.colorScheme.surface),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            FaIcon(FontAwesomeIcons.google),
            Text('Continue with Google'),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Get.offAllNamed(Routes.public.home),
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          backgroundColor: WidgetStatePropertyAll(
            theme.colorScheme.surfaceContainerHigh,
          ),
          foregroundColor: WidgetStatePropertyAll(
            theme.colorScheme.inverseSurface,
          ),
        ),
        child: const Text('Skip Authentication'),
      ),
    );
  }
}
