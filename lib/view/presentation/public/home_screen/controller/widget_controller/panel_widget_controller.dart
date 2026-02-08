import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapollege/core/api/building/building_api.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:mapollege/core/model/building/building_model.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/utility/toast_utility.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/widget_controller/map_widget_controller.dart';

class PanelWidgetController extends GetxController {
  final BuildingApi _buildingApi = BuildingApi(Get.find<DioService>());

  final SlidingUpPanelController panelController = SlidingUpPanelController();

  final Rxn<BuildingModel> building = Rxn<BuildingModel>();
  final RxBool isLoading = false.obs;
  final RxList<Tab> tabs = <Tab>[].obs;
  final RxList<Widget> tabViews = <Widget>[].obs;

  MapWidgetController get _mapWidgetController =>
      Get.find<MapWidgetController>();

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  void _initialize() async {
    building(null);
  }

  Future<void> linePolylinePoints(BuildingModel model) async {
    if (isLoading.value) {
      ToastUtility.show(msg: 'ตำแหน่งยังไม่ถูกโหลด');
      return;
    }
    panelController.collapse();
    await _mapWidgetController.createPolylinePoints(
      LatLng(model.latitude, model.longitude),
    );
  }

  Future<void> getBuilding(String id) async {
    isLoading(true);
    await _buildingApi
        .getBuildingById(id: id)
        .then((b) {
          building(b?.data);
          isLoading(false);
        })
        .catchError((e) {
          isLoading(false);
        });
  }

  void togglePanel() {
    if (panelController.status == SlidingUpPanelStatus.expanded) {
      panelController.collapse();
    } else {
      panelController.anchor();
    }
  }
}
