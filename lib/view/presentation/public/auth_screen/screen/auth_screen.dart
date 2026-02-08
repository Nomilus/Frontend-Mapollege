import 'package:mapollege/config/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/presentation/public/auth_screen/controller/auth_controller.dart';
import 'package:mapollege/view/presentation/public/auth_screen/widget/auth_background_widget.dart';
import 'package:mapollege/view/presentation/public/auth_screen/widget/auth_button_widget.dart';

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
          const Positioned.fill(child: AuthBackgroundWidget()),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(child: _AuthScreenContent()),
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
}

class _AuthScreenContent extends GetView<AuthController> {
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
          AuthButtonWidget(
            title: 'Continue with Google',
            icon: FontAwesomeIcons.google,
            onPressed: () => controller.signIn(),
          ),
          AuthButtonWidget(
            title: 'Skip Authentication',
            onPressed: () => Get.offAllNamed(Routes.public.home),
          ),
        ],
      ),
    );
  }
}
