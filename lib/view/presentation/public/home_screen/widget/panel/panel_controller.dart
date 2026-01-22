import 'package:get/get.dart';
import 'package:mapollege/core/api/building/building_api.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:mapollege/core/model/building/building_model.dart';
import 'package:mapollege/core/service/dio_service.dart';

class PanelController extends GetxController {
  final BuildingApi _buildingApi = BuildingApi(Get.find<DioService>());

  final SlidingUpPanelController panelController = SlidingUpPanelController();

  final Rxn<BuildingModel> building = Rxn<BuildingModel>();
  final RxBool isLoading = true.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   _initialize();
  // }

  // void _initialize() async {
  //   isLoading(true);
  //   await _buildingApi
  //       .getBuildingById(id: 'eb563d2d-e42e-46f4-9be5-73054a1f78bc')
  //       // .getBuildingById(id: '3c593c16-baab-4530-9009-ae8ecfd19ca5')
  //       .then((b) {
  //         building(b?.data);
  //         isLoading(false);
  //       })
  //       .catchError((e) {
  //         isLoading(false);
  //       });
  // }

  void getBuilding(String id) async {
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
    if (SlidingUpPanelStatus.expanded == panelController.status) {
      panelController.collapse();
    } else {
      panelController.anchor();
    }
  }
}
