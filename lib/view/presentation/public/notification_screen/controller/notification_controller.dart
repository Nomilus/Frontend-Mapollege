import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mapollege/core/api/search_api.dart';
import 'package:mapollege/core/enum/table_enum.dart';
import 'package:mapollege/core/model/people/notification_model.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final SearchApi _searchApi = SearchApi(Get.find<DioService>());

  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  CancelToken? _cancelToken;
  Timer? _debounce;

  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxBool isLoading = false.obs;
  RxString searchQuery = ''.obs;
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
    _debounce?.cancel();
    super.onClose();
  }

  void _initialize() async {
    await searchNotification();
  }

  Future<void> refreshNotification() =>
      searchNotification(page: 0, search: searchQuery.value);

  Future<void> searchNotification({int page = 0, String search = ''}) async {
    if (_cancelToken != null && !(_cancelToken!.isCancelled)) {
      _cancelToken!.cancel();
    }

    _cancelToken = CancelToken();

    isLoading(true);
    final response = await _searchApi.searchGeneral(
      search: search,
      table: TableEnum.notification,
      page: page,
      size: 10,
      parser: NotificationModel.fromModel,
    );

    if (response?.data != null) {
      notifications.assignAll(response!.data.content);
      currentPage.value = response.data.pageNumber;
      totalPages.value = response.data.totalPages;
      totalElements.value = response.data.totalElements;
    }

    notifications.refresh();
    isLoading(false);
  }

  void onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchQuery.value = value;
      searchNotification(page: 0, search: value);
    });
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
      searchNotification(page: page, search: searchQuery.value);
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
}
