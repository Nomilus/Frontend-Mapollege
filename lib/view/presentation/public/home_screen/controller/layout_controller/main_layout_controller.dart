import 'dart:async';

import 'package:mapollege/core/api/search_api.dart';
import 'package:mapollege/core/enum/table_enum.dart';
import 'package:mapollege/core/model/building/building_model.dart';
import 'package:mapollege/core/model/people/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapollege/core/service/auth_service.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/widget_controller/map_widget_controller.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/widget_controller/panel_widget_controller.dart';

class MainLayoutController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final SearchApi _searchApi = SearchApi(Get.find<DioService>());

  final TextEditingController searchController = TextEditingController();

  AnimationController? refreshController;
  DateTime? lastPressed;

  RxList<BuildingModel> searchResponse = <BuildingModel>[].obs;
  RxBool isLoanding = false.obs;
  RxString searchQuery = ''.obs;
  Timer? _debounce;

  UserModel? get currentUser =>
      _authService.isLoggedIn.value ? _authService.currentUser.value : null;

  PanelWidgetController get panelWidgetController =>
      Get.find<PanelWidgetController>();
  MapWidgetController get mapWidgetController =>
      Get.find<MapWidgetController>();

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }

  Future<void> _searchBuilding({int page = 0, String search = ''}) async {
    isLoanding(true);
    final response = await _searchApi.searchGeneral<BuildingModel>(
      search: search,
      table: TableEnum.building,
      page: page,
      size: 5,
      parser: BuildingModel.fromModel,
    );

    final modelContent = response?.data.content ?? [];

    if (modelContent.isEmpty) {
      searchResponse.clear();
    }

    if (modelContent.isNotEmpty) {
      searchResponse.assignAll(modelContent);
    }

    searchResponse.refresh();
    isLoanding(false);
  }

  Future<void> get refreshBuilding =>
      _searchBuilding(page: 0, search: searchQuery.value);

  void onSearchChanged(String value) {
    if (searchController.text == '') {
      searchResponse.clear();
    } else {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        searchQuery(value);
        _searchBuilding(page: 0, search: value);
      });
    }
  }

  void onSearchClick(String id) {
    mapWidgetController.moveToMarker(id);
    panelWidgetController.getBuilding(id);
    panelWidgetController.togglePanel();
    searchController.clear();
    searchResponse.clear();
    searchResponse.refresh();
  }
}
