import 'package:mapollege/view/presentation/public/home_screen/widget/panel/panel_controller.dart';
import 'package:mapollege/core/api/building/building_api.dart';
import 'package:mapollege/core/api/college/college_api.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/service/location_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapollege/core/service/theme_service.dart';
import 'package:mapollege/core/utility/overlay_utility.dart';
import 'package:mapollege/core/utility/snackbar_utility.dart';

class MapController extends GetxController {
  final PanelController _panelController = Get.find<PanelController>();

  final LocationService _locationService = Get.find<LocationService>();
  final ThemeService _themeService = Get.find<ThemeService>();
  final BuildingApi _buildingApi = BuildingApi(Get.find<DioService>());
  final CollegeApi _collegeApi = CollegeApi(Get.find<DioService>());

  final Rxn<GoogleMapController> mapController = Rxn<GoogleMapController>();
  final Rx<BitmapDescriptor> bitmap = Rx<BitmapDescriptor>(
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
  );
  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxSet<Polyline> polyline = <Polyline>{}.obs;
  final RxBool isSatellite = false.obs;

  late final PolylinePoints polylinePoints;

  List<Marker> _allBuilding = [];
  List<Marker> _allCollege = [];

  bool get isDarkMode => _themeService.isDarkMode.value;

  String get mapStyle => '';

  @override
  void onInit() {
    super.onInit();
    polylinePoints = PolylinePoints(
      apiKey: dotenv.env['GOOGLE_MAP_API_KEY'] ?? '',
    );
  }

  @override
  void onReady() {
    super.onReady();
    _initialize();
  }

  @override
  void onClose() {
    mapController.value?.dispose();
    super.onClose();
  }

  void _initialize() async {
    OverlayUtility.showLoading();
    try {
      _initBuilding();
      _initCollege();
    } finally {
      OverlayUtility.hideOverlay();
    }
  }

  Future<void> _initBuilding() async {
    try {
      final response = await _buildingApi.getAllBuildings();

      final buildings = response?.data;
      if (buildings == null) return;

      final listMarker = buildings.map(
        (b) => Marker(
          markerId: MarkerId(b.id),
          position: LatLng(b.latitude, b.longitude),
          infoWindow: InfoWindow(title: b.name),
          onTap: () {
            _panelController.getBuilding(b.id);
            _panelController.togglePanel();
          },
          icon: bitmap.value,
        ),
      );

      _allBuilding = listMarker.toList();
      markers.assignAll(listMarker);
      markers.refresh();
    } catch (e) {
      SnackbarUtility.error(
        title: 'เกิดข้อผิดพลาด',
        message: 'ไม่สามารถใช้เรียกงานอาคารได้',
      );
    }
  }

  Future<void> _initCollege() async {
    try {
      final response = await _collegeApi.getAllCollege();

      final colleges = response?.data;
      if (colleges == null) return;

      final listMarker = colleges.map(
        (b) => Marker(
          markerId: MarkerId(b.id),
          position: LatLng(b.latitude, b.longitude),
          infoWindow: InfoWindow(title: b.name),
          icon: bitmap.value,
        ),
      );

      _allCollege = listMarker.toList();
    } catch (e) {
      SnackbarUtility.error(
        title: 'เกิดข้อผิดพลาด',
        message: 'ไม่สามารถใช้เรียกงานอาคารได้',
      );
    }
  }

  void toggleMapType(bool value) => isSatellite(value);

  void onZoomChanged(double zoom) {
    if (zoom <= 14.5) {
      markers.assignAll(_allCollege.toSet());
    } else {
      markers.assignAll(_allBuilding.toSet());
    }
    markers.refresh();
  }

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
