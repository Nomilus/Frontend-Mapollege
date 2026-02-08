import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapollege/core/model/building/location_model.dart';
import 'package:mapollege/core/model/college/college_model.dart';
import 'package:mapollege/core/model/mix_model.dart';
import 'package:mapollege/core/utility/map_utility.dart';
import 'package:mapollege/core/utility/parse_utility.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/widget_controller/panel_widget_controller.dart';
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

class MapWidgetController extends GetxController {
  final GlobalKey markerKey = GlobalKey();

  final LocationService _locationService = Get.find<LocationService>();
  final ThemeService _themeService = Get.find<ThemeService>();

  final BuildingApi _buildingApi = BuildingApi(Get.find<DioService>());
  final CollegeApi _collegeApi = CollegeApi(Get.find<DioService>());

  final Rxn<LocationModel> markerTemplateModel = Rxn<LocationModel>();
  final Rxn<GoogleMapController> mapController = Rxn<GoogleMapController>();
  final Rxn<CameraPosition> lastCameraPosition = Rxn<CameraPosition>();
  final Rx<BitmapDescriptor> bitmap = Rx<BitmapDescriptor>(
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
  );
  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxSet<Polyline> polyline = <Polyline>{}.obs;
  final RxString mapStyle = ''.obs;
  final RxBool showMap = false.obs;

  late PolylinePoints _polylinePoints;
  late String _darkStyle;
  late String _lightStyle;

  final Map<String, Marker> _allBuildingMarker = {};
  final Map<String, Marker> _allCollegeMarker = {};

  double _lastZoom = 0;

  PanelWidgetController get _panelWidgetController =>
      Get.find<PanelWidgetController>();

  @override
  void onInit() {
    super.onInit();
    _polylinePoints = PolylinePoints(
      apiKey: dotenv.env['GOOGLE_MAP_API_KEY'] ?? '',
    );
  }

  @override
  void onReady() {
    super.onReady();
    _bootstrap();
  }

  @override
  void onClose() {
    mapController.value = null;
    mapController.value?.dispose();
    super.onClose();
  }

  Future<void> _bootstrap() async {
    await Future.wait([_loadMapStyle(), _loadMarkers()]);
    showMap(true);
  }

  Future<void> _loadMapStyle() async {
    _darkStyle = await rootBundle.loadString('assets/jsons/map_dark.json');
    _lightStyle = await rootBundle.loadString('assets/jsons/map_light.json');
    ever<bool>(_themeService.isDarkMode, (isDark) {
      mapStyle.value = isDark ? _darkStyle : _lightStyle;
    });
    mapStyle.value = _themeService.isDarkMode.value ? _darkStyle : _lightStyle;
  }

  Future<void> _loadMarkers() async {
    try {
      final results = await Future.wait([
        _buildingApi.getAllBuildings(),
        _collegeApi.getAllCollege(),
      ]);

      _allBuildingMarker.addAll(
        await _createMarkers(
          results[0]?.data as List<LocationModel>? ?? [],
          onTap: (id) {
            _panelWidgetController.getBuilding(id);
            _panelWidgetController.togglePanel();
          },
        ),
      );

      _allCollegeMarker.addAll(
        await _createMarkers(
          results[1]?.data as List<CollegeModel>? ?? [],
          onTap: (_) {},
        ),
      );

      markers.assignAll(_allCollegeMarker.values);
    } catch (e) {
      SnackbarUtility.error(
        title: 'เกิดข้อผิดพลาด',
        message: 'โหลดแผนที่ไม่สำเร็จ',
        error: e.toString(),
      );
    }
  }

  Future<Map<String, Marker>> _createMarkers(
    List<MixLocationModel> list, {
    required void Function(String id) onTap,
  }) async {
    final icons = await Future.wait(
      list.map((e) => MapUtility.createMarker(id: e.id, label: e.name)),
    );

    return Map.fromEntries(
      List.generate(list.length, (i) {
        final item = list[i];
        return MapEntry(
          item.id,
          Marker(
            markerId: MarkerId(item.id),
            position: LatLng(item.latitude, item.longitude),
            icon: icons[i],
            onTap: () => onTap(item.id),
          ),
        );
      }),
    );
  }

  Future<void> _animate(CameraUpdate update) async {
    final controller = mapController.value;
    if (controller == null) return;
    await controller.animateCamera(update);
  }

  LatLngBounds _boundsFromLatLngs(LatLng a, LatLng b) {
    double minLat = a.latitude < b.latitude ? a.latitude : b.latitude;
    double minLng = a.longitude < b.longitude ? a.longitude : b.longitude;
    double maxLat = a.latitude > b.latitude ? a.latitude : b.latitude;
    double maxLng = a.longitude > b.longitude ? a.longitude : b.longitude;

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  Future<void> rotateCamera() async {
    try {
      final controller = mapController.value;
      if (controller == null) return;
      final LatLngBounds bounds = await controller.getVisibleRegion();
      final double zoom = await controller.getZoomLevel();
      final LatLng target = LatLng(
        (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
        (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
      );
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: target, zoom: zoom, tilt: 0, bearing: 0),
        ),
      );
    } catch (e) {
      SnackbarUtility.error(title: 'เกิดข้อผิดพลาด', message: '');
    }
  }

  Future<void> createPolylinePoints(LatLng location) async {
    OverlayUtility.showLoading();
    polyline.clear();
    debugPrint('ทำลังทำงาน');
    try {
      final currentLocation = await _locationService.getCurrentLocation();
      if (currentLocation == null) return;
      debugPrint('ได้นะ');
      final bounds = _boundsFromLatLngs(currentLocation, location);

      final RoutesApiResponse linePoints = await _polylinePoints
          .getRouteBetweenCoordinatesV2(
            request: RoutesApiRequest(
              origin: PointLatLng(
                currentLocation.latitude,
                currentLocation.longitude,
              ),
              destination: PointLatLng(location.latitude, location.longitude),
            ),
          );

      debugPrint('มาวะ');

      if (linePoints.isSuccessful) {
        final raw = await compute(
          ParseUtility.parsePoints,
          linePoints.primaryRoute!.polylinePoints!,
        );

        final points = raw.map((e) => LatLng(e[0], e[1])).toList();

        if (points.isEmpty) return;
        polyline.assignAll({
          MapUtility.createPolyline(
            id: 'line-start',
            patterns: [PatternItem.gap(10), PatternItem.dot],
            points: [
              points[points.length - 1],
              LatLng(location.latitude, location.longitude),
            ],
          ),
          MapUtility.createPolyline(id: 'line-center', points: points),
          MapUtility.createPolyline(
            id: 'line-end',
            patterns: [PatternItem.gap(10), PatternItem.dot],
            points: [
              LatLng(currentLocation.latitude, currentLocation.longitude),
              points[0],
            ],
          ),
        });

        await _animate(CameraUpdate.newLatLngBounds(bounds, 50));
        debugPrint('ได้เฉย');
        polyline.refresh();
      }
    } finally {
      OverlayUtility.hideOverlay();
    }
  }

  Future<void> moveToSelfLocation() async {
    OverlayUtility.showLoading();
    try {
      final currentLocation = await _locationService.getCurrentLocation();
      if (currentLocation == null) return;
      await _animate(CameraUpdate.newLatLngZoom(currentLocation, 20));
    } finally {
      OverlayUtility.hideOverlay();
    }
  }

  Future<void> moveToLocation(LatLng location, double zoom) async {
    OverlayUtility.showLoading();
    try {
      await _animate(CameraUpdate.newLatLngZoom(location, zoom));
    } finally {
      OverlayUtility.hideOverlay();
    }
  }

  Future<void> moveToMarker(String markerId) async {
    final marker = _allBuildingMarker[markerId];
    if (marker == null) return;
    OverlayUtility.showLoading();
    try {
      await _animate(CameraUpdate.newLatLngZoom(marker.position, 20));
    } finally {
      OverlayUtility.hideOverlay();
    }
  }

  void handleCameraIdle() {
    final lastZoomPosition = lastCameraPosition.value?.zoom;
    if (lastZoomPosition == null) return;
    if ((lastZoomPosition - _lastZoom).abs() < 0.3) return;
    _lastZoom = lastZoomPosition;

    final next = lastZoomPosition <= 18
        ? _allCollegeMarker.values
        : _allBuildingMarker.values;

    if (markers.length != next.length) {
      markers.assignAll(next);
    }
  }
}
