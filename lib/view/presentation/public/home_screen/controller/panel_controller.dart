import 'package:application_mapollege/core/api/building/building_api.dart';
import 'package:application_mapollege/core/model/building/building_model.dart';
import 'package:application_mapollege/core/service/dio_service.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:get/get.dart';

class PanelController extends GetxController {
  final BuildingApi _buildingApi = BuildingApi(Get.find<DioService>());

  final Rx<SlidingUpPanelController> panelController = Rx(
    SlidingUpPanelController(),
  );

  final Rxn<BuildingModel> building = Rxn<BuildingModel>();
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  Future<void> _initialize() async {
    isLoading(true);
    await _buildingApi
        .getBuildingById(id: '208ebd5a-a89b-4936-a59f-09b5d4f2d5cc')
        .then((b) {
          building(b?.data);
          isLoading(false);
        })
        .catchError((e) {
          isLoading(false);
        });
  }
}
