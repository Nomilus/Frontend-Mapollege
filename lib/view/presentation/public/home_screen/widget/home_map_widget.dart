import 'package:mapollege/view/presentation/public/home_screen/controller/widget_controller/map_widget_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends GetView<MapWidgetController> {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Obx(() {
      if (!controller.showMap.value) {
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        );
      }
      return GoogleMap(
        style: controller.mapStyle.value,
        onMapCreated: (value) => controller.mapController(value),
        onCameraMove: (position) => controller.lastCameraPosition(position),
        onCameraIdle: () => controller.handleCameraIdle(),
        markers: controller.markers.toSet(),
        polylines: controller.polyline.toSet(),
        polygons: {
          Polygon(
            polygonId: const PolygonId('area_1'),
            points: const [
              LatLng(15.2408781371321, 104.84229893251283),
              LatLng(15.243460073892004, 104.84261182217946),
              LatLng(15.242782210788235, 104.84716071745179),
              LatLng(15.24061397558487, 104.84700582276315),
            ],
            strokeWidth: 2,
            strokeColor: theme.colorScheme.primary,
            fillColor: theme.colorScheme.primary.withValues(alpha: 0.2),
          ),
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(15.241698067868498, 104.8454945672114),
          zoom: 16,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        mapToolbarEnabled: false,
        compassEnabled: false,
      );
    });
  }
}
