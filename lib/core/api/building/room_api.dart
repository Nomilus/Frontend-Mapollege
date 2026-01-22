import 'package:mapollege/core/model/building/room_model.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/utility/error_utility.dart';
import 'package:mapollege/core/model/response_model.dart';
import 'package:dio/dio.dart';

class RoomApi {
  RoomApi(this._dio);

  final DioService _dio;
  final String requestPath = '/building/room';

  Future<ResponseModel<RoomModel>?> createRoom({
    required String buildingId,
    required String roomName,
    required String roomNumber,
    required String floor,
    String? description,
    bool isActive = true,
    List<String>? imagePaths,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'buildingId': buildingId,
        'roomName': roomName,
        'roomNumber': roomNumber,
        'floor': floor,
        'description': description,
        'isActive': isActive,
      };

      if (imagePaths != null && imagePaths.isNotEmpty) {
        data['images'] = [
          for (String path in imagePaths) await MultipartFile.fromFile(path),
        ];
      }

      final formData = FormData.fromMap(data, ListFormat.multiCompatible);
      final response = await _dio.dio.post(requestPath, data: formData);

      return ResponseModel.fromModel(RoomModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<RoomModel>?> updateRoom({
    required String id,
    required String buildingId,
    required String roomName,
    required String roomNumber,
    required String floor,
    String? description,
    bool isActive = true,
    List<String>? imagePaths,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'id': id,
        'buildingId': buildingId,
        'roomName': roomName,
        'roomNumber': roomNumber,
        'floor': floor,
        'description': description,
        'isActive': isActive,
      };

      if (imagePaths != null && imagePaths.isNotEmpty) {
        data['images'] = [
          for (String path in imagePaths) await MultipartFile.fromFile(path),
        ];
      }

      final formData = FormData.fromMap(data, ListFormat.multiCompatible);
      final response = await _dio.dio.put(requestPath, data: formData);

      return ResponseModel.fromModel(RoomModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<RoomModel>?> updateActive({
    required String id,
    required bool isActive,
  }) async {
    try {
      final response = await _dio.dio.put(
        '$requestPath/$id',
        queryParameters: {'active': isActive},
      );
      return ResponseModel.fromModel(RoomModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<RoomModel>?> getRoomByid({required String id}) async {
    try {
      final response = await _dio.dio.get('$requestPath/$id');
      return ResponseModel.fromModel(RoomModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<bool>?> deleteRoom({required String id}) async {
    try {
      final response = await _dio.dio.delete('$requestPath/$id');
      return ResponseModel.fromRaw(response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
