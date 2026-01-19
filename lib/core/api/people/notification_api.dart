import 'package:mapollege/core/model/people/notification_model.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/utility/error_utility.dart';
import 'package:mapollege/core/utility/response_utility.dart';
import 'package:dio/dio.dart';

class NotificationApi {
  NotificationApi(this._dio);

  final DioService _dio;
  final String requestPath = '/notification';

  Future<ResponseUtility<bool>?> createNotification({
    required String title,
    required String message,
    bool isRead = false,
  }) async {
    try {
      final response = await _dio.dio.post(
        requestPath,
        data: {"title": title, "message": message, "isRead": isRead},
      );
      return ResponseUtility.fromRaw(response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<NotificationModel>?> updateReadStatus({
    required String id,
    required bool isRead,
  }) async {
    try {
      final response = await _dio.dio.patch(
        '$requestPath/$id',
        queryParameters: {"read": isRead},
      );
      return ResponseUtility.fromModel(
        NotificationModel.fromModel,
        response.data,
      );
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
  
  Future<ResponseUtility<List<NotificationModel>>?>
  getAllNotifications() async {
    try {
      final response = await _dio.dio.get(requestPath);
      return ResponseUtility.fromList(
        NotificationModel.fromModel,
        response.data,
      );
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<bool>?> deleteNotification({
    required String id,
  }) async {
    try {
      final response = await _dio.dio.delete('$requestPath/$id');
      return ResponseUtility.fromRaw(response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
