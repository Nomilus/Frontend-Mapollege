import 'package:get/get.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/layout_controller/scan_layout_controller.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/widget_controller/map_widget_controller.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/widget_controller/panel_widget_controller.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;

  MapWidgetController get mapWidgetController =>
      Get.find<MapWidgetController>();
  PanelWidgetController get _panelWidgetController =>
      Get.find<PanelWidgetController>();
  ScanLayoutController get _scanLayoutController =>
      Get.find<ScanLayoutController>();

  Future<void> showBuilding(String id) async {
    _panelWidgetController.getBuilding(id);
    _panelWidgetController.panelController.anchor();
    mapWidgetController.moveToMarker(id);
  }

  void changePage(int index) {
    _scanLayoutController.offFlash();
    currentIndex(index);
  }
}
