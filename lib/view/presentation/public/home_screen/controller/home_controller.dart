import 'dart:async';

import 'package:mapollege/core/api/search_api.dart';
import 'package:mapollege/core/model/building/building_model.dart';
import 'package:mapollege/core/model/people/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapollege/core/service/auth_service.dart';
import 'package:mapollege/core/service/dio_service.dart';

class HomeController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final SearchApi _searchApi = SearchApi(Get.find<DioService>());

  AnimationController? refreshController;

  final TextEditingController searchController = TextEditingController();

  RxList<BuildingModel> searchResponse = <BuildingModel>[].obs;
  RxBool isLoanding = false.obs;
  RxString searchQuery = ''.obs;
  Timer? _debounce;

  UserModel? get currentUser =>
      _authService.isLoggedIn.value ? _authService.currentUser.value : null;

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  @override
  void onClose() {
    searchController.dispose();
    _debounce?.cancel();
    super.onClose();
  }

  Future<void> _initialize({int page = 0, String search = ''}) async {
    isLoanding(true);
    final response = await _searchApi.searchGeneral<BuildingModel>(
      parser: BuildingModel.fromModel,
      search: search,
      page: page,
      size: 10,
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
      _initialize(page: 0, search: searchQuery.value);

  void onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchQuery(value);
      _initialize(page: 0, search: value);
    });
  }

  void clearSearch() {
    searchController.clear();
    searchQuery('');
    _initialize(page: 0, search: '');
  }
}
