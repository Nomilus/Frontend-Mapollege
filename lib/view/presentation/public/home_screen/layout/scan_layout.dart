import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/layout_controller/scan_layout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanLayout extends GetView<ScanLayoutController> {
  const ScanLayout({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Stack(
      children: [
        Positioned.fill(
          child: MobileScanner(
            controller: controller.scannerController,
            onDetect: controller.onDetect,
          ),
        ),
        Positioned.fill(child: CustomPaint(painter: _ScanLayout(context))),
        Positioned(
          top: 16,
          right: 16,
          child: SafeArea(
            child: IconButton(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.xmark),
              style: ButtonStyle(
                shadowColor: const WidgetStatePropertyAll(Colors.black),
                elevation: const WidgetStatePropertyAll(2),
                backgroundColor: WidgetStatePropertyAll(
                  theme.colorScheme.surfaceContainerHigh,
                ),
                foregroundColor: WidgetStatePropertyAll(
                  theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: SafeArea(
            child: Obx(() {
              final isOn = controller.isFlashOn.value;

              return ElevatedButton.icon(
                onPressed: () => controller.toggleFlash(),
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(
                        width: 1,
                        color: theme.colorScheme.surfaceContainerHighest,
                      ),
                    ),
                  ),
                  shadowColor: const WidgetStatePropertyAll(Colors.black),
                  elevation: const WidgetStatePropertyAll(2),
                  backgroundColor: WidgetStatePropertyAll(
                    isOn
                        ? theme.colorScheme.surfaceContainerHigh
                        : theme.colorScheme.primaryContainer,
                  ),
                ),
                label: Text(
                  isOn ? 'ปิดไฟ' : 'เปิดไฟ',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isOn
                        ? theme.colorScheme.onSurfaceVariant
                        : theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                icon: FaIcon(
                  isOn ? FontAwesomeIcons.xmark : FontAwesomeIcons.bolt,
                  color: isOn
                      ? theme.colorScheme.onSurfaceVariant
                      : theme.colorScheme.onPrimaryContainer,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _ScanLayout extends CustomPainter {
  _ScanLayout(this.context);

  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) {
    const scanBoxSize = 126;
    const radius = 30.0;
    const line = (126 * 0.35);
    const padding = 8;

    final thmem = Theme.of(context);

    final backgroundPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final boxCenter = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width - scanBoxSize,
      height: size.width - scanBoxSize,
    );

    final scanBoxPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          boxCenter,
          const Radius.circular(radius - padding),
        ),
      );

    final combinedPath = Path.combine(
      PathOperation.difference,
      backgroundPath,
      scanBoxPath,
    );

    canvas.drawPath(combinedPath, backgroundPaint);

    final borderPaint = Paint()
      ..color = thmem.colorScheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;

    final borderLeft = boxCenter.left - padding;
    final borderTop = boxCenter.top - padding;
    final borderRight = boxCenter.right + padding;
    final borderBottom = boxCenter.bottom + padding;

    final borderPath = Path()
      ..moveTo(borderLeft, borderTop + line)
      ..lineTo(borderLeft, borderTop + radius)
      ..quadraticBezierTo(borderLeft, borderTop, borderLeft + radius, borderTop)
      ..lineTo(borderLeft + line, borderTop)
      ..moveTo(borderRight, borderTop + line)
      ..lineTo(borderRight, borderTop + radius)
      ..quadraticBezierTo(
        borderRight,
        borderTop,
        borderRight - radius,
        borderTop,
      )
      ..lineTo(borderRight - line, borderTop)
      ..moveTo(borderLeft, borderBottom - line)
      ..lineTo(borderLeft, borderBottom - radius)
      ..quadraticBezierTo(
        borderLeft,
        borderBottom,
        borderLeft + radius,
        borderBottom,
      )
      ..lineTo(borderLeft + line, borderBottom)
      ..moveTo(borderRight, borderBottom - line)
      ..lineTo(borderRight, borderBottom - radius)
      ..quadraticBezierTo(
        borderRight,
        borderBottom,
        borderRight - radius,
        borderBottom,
      )
      ..lineTo(borderRight - line, borderBottom);

    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
