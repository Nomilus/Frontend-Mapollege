import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService extends GetxService {

  @override
  void onInit() {
    super.onInit();
    _checkPermissionLocation();
  }

  Future<bool> _checkPermissionLocation() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return false;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      return permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    } catch (e) {
      return false;
    }
  }

  Future<LatLng?> getCurrentLocation() async {
      final hasPermission = await _checkPermissionLocation();
      if (!hasPermission) return null;
      final position = await Geolocator.getCurrentPosition();
      return LatLng(position.latitude, position.longitude);
  }
}
