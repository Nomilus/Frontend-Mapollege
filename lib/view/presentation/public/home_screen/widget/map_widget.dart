import 'package:application_mapollege/view/presentation/public/home_screen/controller/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends GetView<MapController> {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GoogleMap(
        onMapCreated: (value) => controller.mapController(value),
        markers: controller.markers.toSet(),
        polylines: controller.polyline.toSet(),
        initialCameraPosition: const CameraPosition(
          target: LatLng(13.7563, 100.5018),
          zoom: 11,
        ),
        mapType: controller.isSatellite.value ? MapType.hybrid : MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        mapToolbarEnabled: false,
        compassEnabled: false,
      );
    });
  }
}
