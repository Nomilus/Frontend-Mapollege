import 'package:application_mapollege/core/model/people/notification_model.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final RxList<NotificationModel> notifications = RxList<NotificationModel>();
  final RxBool isLoading = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  Future<void> refreshNotifications() async {}
}
