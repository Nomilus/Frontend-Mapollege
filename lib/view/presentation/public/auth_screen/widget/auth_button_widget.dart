import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/presentation/private/profile_screen/controller/profile_controller.dart';

class AuthButtonWidget extends GetView<ProfileController> {
  const AuthButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String title;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          foregroundColor: WidgetStatePropertyAll(foregroundColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [FaIcon(icon), Text(title)],
        ),
      ),
    );
  }
}
