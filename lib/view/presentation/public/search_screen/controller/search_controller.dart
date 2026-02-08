import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mapollege/config/router/routes.dart';
import 'package:mapollege/core/api/search_api.dart';
import 'package:mapollege/core/enum/direction_enum.dart';
import 'package:mapollege/core/enum/sort_enum.dart';
import 'package:mapollege/core/enum/table_enum.dart';
import 'package:mapollege/core/model/building/building_model.dart';
import 'package:mapollege/core/model/building/room_model.dart';
import 'package:mapollege/core/model/people/person_model.dart';
import 'package:mapollege/core/model/section/department_model.dart';
import 'package:mapollege/core/model/section/work_model.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/view/presentation/public/home_screen/controller/home_controller.dart';

class SearchGetController extends GetxController {
  final SearchApi _searchApi = SearchApi(Get.find<DioService>());

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  CancelToken? _cancelToken;
  Timer? _debounce;

  RxList<dynamic> listResult = <dynamic>[].obs;
  Rx<TableEnum> tableSelected = TableEnum.building.obs;
  Rx<DirectionEnum> directionSelected = DirectionEnum.asc.obs;
  RxInt pageSizeSelected = 10.obs;
  RxString searchQuery = ''.obs;
  RxBool isLoading = false.obs;
  RxInt currentPage = 0.obs;
  RxInt totalPages = 0.obs;
  RxInt totalElements = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.dispose();
    _debounce?.cancel();
    super.onClose();
  }

  void _initialize() async {
    await searchTable();
  }

  Future<void> refreshResult() =>
      searchTable(page: 0, search: searchQuery.value);

  Future<void> searchTable({int page = 0, String search = ''}) async {
    if (_cancelToken != null && !(_cancelToken!.isCancelled)) {
      _cancelToken!.cancel();
    }

    _cancelToken = CancelToken();

    isLoading(true);
    final response = await _searchApi.searchGeneral(
      search: search,
      table: tableSelected.value,
      page: page,
      size: pageSizeSelected.value,
      sort: SortEnum.name,
      direction: directionSelected.value,
      parser: tableSelected.value.parser,
    );

    if (response?.data != null) {
      listResult.assignAll(response!.data.content);
      currentPage.value = response.data.pageNumber;
      totalPages.value = response.data.totalPages;
      totalElements.value = response.data.totalElements;
    }

    listResult.refresh();
    isLoading(false);
  }

  void onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchQuery.value = value;
      searchTable(page: 0, search: value);
    });
  }

  void onTableChanged(TableEnum? table) {
    if (table != null) tableSelected.value = table;
    currentPage.value = 0;
    searchTable(page: 0, search: searchQuery.value);
  }

  void onPageSizeChanged(int? value) {
    if (value != null) {
      pageSizeSelected.value = value;
      searchTable(page: 0, search: searchQuery.value);
    }
  }

  void onDirectionChanged(DirectionEnum? direction) {
    if (direction != null) directionSelected.value = direction;
    currentPage.value = 0;
    searchTable(page: 0, search: searchQuery.value);
  }

  void scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void goToPage(int page) {
    if (page >= 0 && page < totalPages.value) {
      searchTable(page: page, search: searchQuery.value);
    }
  }

  void nextPage() {
    if (currentPage.value < totalPages.value - 1) {
      goToPage(currentPage.value + 1);
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      goToPage(currentPage.value - 1);
    }
  }

  void showMore(dynamic model) {
    switch (model) {
      case BuildingModel building:
        {
          Get.find<HomeController>().showBuilding(building.id);
          Get.until((route) => Get.currentRoute == Routes.public.home);
        }
        break;
      case RoomModel room:
        {
          Get.toNamed(
            Routes.public.room,
            arguments: room.id,
            preventDuplicates: false,
          );
        }
        break;
      case PersonModel _:
        break;
      case DepartmentModel _:
        break;
      case WorkModel _:
        break;
      default:
        break;
    }
  }
}
