import 'package:flutter/material.dart';
import 'package:mapollege/core/api/building/room_api.dart';
import 'package:get/get.dart';
import 'package:mapollege/core/model/building/room_model.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/home_controller.dart';

class RoomController extends GetxController {
  final RoomApi _roomApi = RoomApi(Get.find<DioService>());

  final Rxn<RoomModel> room = Rxn<RoomModel>();
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  void _initialize() async {
    await getRoom();
  }

  Future<void> refreshRoom() => getRoom();

  Future<void> getRoom() async {
    final currentId = Get.arguments;
    debugPrint("room id model: $currentId");

    if (currentId == null) return;

    isLoading(true);
    _roomApi
        .getRoomByid(id: currentId)
        .then((r) {
          room(r?.data);
          isLoading(false);
        })
        .catchError((e) {
          isLoading(false);
        });
  }

  void goBuilding() {
    final buildingId = room.value?.buildingId;

    if (buildingId != null) {
      Get.find<HomeController>().showBuilding(buildingId);
    }
  }
}
