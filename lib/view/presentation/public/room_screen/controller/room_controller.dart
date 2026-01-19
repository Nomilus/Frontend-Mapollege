import 'package:mapollege/core/api/building/room_api.dart';
import 'package:get/get.dart';
import 'package:mapollege/core/model/building/room_model.dart';
import 'package:mapollege/core/service/dio_service.dart';

class RoomController extends GetxController {
  final RoomApi _roomApi = RoomApi(Get.find<DioService>());

  final Rxn<RoomModel> room = Rxn<RoomModel>();
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  Future<void> _initialize() async {
    getRoom();
  }

  Future<void> getRoom() async {
    isLoading(true);
    _roomApi
        .getRoomByid(id: Get.arguments)
        .then((r) {
          room(r?.data);
          isLoading(false);
        })
        .catchError((e) {
          isLoading(false);
        });
  }
}
