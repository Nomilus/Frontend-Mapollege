import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtility {
  static final Map<String, BitmapDescriptor> _cache = {};

  static Future<BitmapDescriptor> createMarker({
    required String id,
    required String label,
  }) async {
    final key = 'marker-$id';

    if (_cache.containsKey(key)) {
      return _cache[key]!;
    }

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    const padding = 8.0;

    final paint = Paint()..color = Get.theme.colorScheme.primaryContainer;

    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: Get.theme.textTheme.bodySmall?.copyWith(
          color: Get.theme.colorScheme.onPrimaryContainer,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    canvas.drawRRect(
      RRect.fromLTRBR(
        0,
        0,
        textPainter.width + (padding * 2),
        textPainter.height + (padding * 2),
        const Radius.circular(10),
      ),
      paint,
    );

    textPainter.paint(canvas, const Offset(padding, padding));

    final image = await recorder.endRecording().toImage(
      (textPainter.width + (padding * 2)).toInt(),
      (textPainter.height + (padding * 2)).toInt(),
    );

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bitmap = BitmapDescriptor.bytes(byteData!.buffer.asUint8List());

    _cache[key] = bitmap;
    return bitmap;
  }

  static Polyline createPolyline({
    required String id,
    List<LatLng> points = const <LatLng>[],
    List<PatternItem> patterns = const <PatternItem>[],
  }) {
    return Polyline(
      polylineId: PolylineId("polyline-$id"),
      color: Colors.yellow,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      patterns: patterns,
      points: points,
    );
  }
}
