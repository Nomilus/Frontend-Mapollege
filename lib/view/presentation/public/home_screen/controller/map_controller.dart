import 'package:mapollege/core/service/location_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapollege/core/utility/overlay_utility.dart';
import 'package:mapollege/core/utility/snackbar_utility.dart';

class MapController extends GetxController {
  final LocationService _locationService = Get.find<LocationService>();

  final Rxn<GoogleMapController> mapController = Rxn<GoogleMapController>();
  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxSet<Polyline> polyline = <Polyline>{}.obs;
  final RxBool isSatellite = false.obs;

  late final PolylinePoints polylinePoints;

  @override
  void onInit() {
    super.onInit();
    polylinePoints = PolylinePoints(
      apiKey: dotenv.env['GOOGLE_MAP_API_KEY'] ?? '',
    );
  }

  @override
  void onClose() {
    mapController.value?.dispose();
    super.onClose();
  }

  void toggleMapType(bool value) => isSatellite(value);

  Future<void> moveToSelfLocation() async {
    try {
      OverlayUtility.showLoading();
      final currentLocation = await _locationService.getCurrentLocation();

      if (currentLocation == null) return;

      await mapController.value?.animateCamera(
        CameraUpdate.newLatLngZoom(currentLocation, 16),
      );
    } catch (e) {
      SnackbarUtility.error(
        title: 'เกิดข้อผิดพลาด',
        message: 'ไม่สามารถรับตำแหน่งปัจจุบันได้',
      );
    } finally {
      OverlayUtility.hideOverlay();
    }
  }

  Future<void> moveToLocation(LatLng location) async {
    try {
      OverlayUtility.showLoading();
      await mapController.value?.animateCamera(
        CameraUpdate.newLatLngZoom(location, 16),
      );
    } catch (e) {
      SnackbarUtility.error(
        title: 'เกิดข้อผิดพลาด',
        message: 'ไม่สามารถไปยังตำแหน่งที่ต้องการได้',
      );
    } finally {
      OverlayUtility.hideOverlay();
    }
  }
}
