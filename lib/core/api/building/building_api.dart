import 'package:flutter/widgets.dart';
import 'package:mapollege/core/model/building/building_model.dart';
import 'package:mapollege/core/model/building/location_model.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/utility/error_utility.dart';
import 'package:mapollege/core/model/response_model.dart';
import 'package:dio/dio.dart';

class BuildingApi {
  BuildingApi(this._dio);

  final DioService _dio;
  final String requestPath = '/building';

  Future<ResponseModel<BuildingModel>?> createBuilding({
    required String name,
    required String address,
    String? description,
    required double latitude,
    required double longitude,
    required int floorCount,
    bool isActive = true,
    List<String>? imagePaths,
  }) async {
    try {
      final Map<String, dynamic> map = {
        'name': name,
        'address': address,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'floorCount': floorCount,
        'isActive': isActive,
      };

      if (imagePaths != null && imagePaths.isNotEmpty) {
        map['images'] = [
          for (String path in imagePaths) await MultipartFile.fromFile(path),
        ];
      }

      final formData = FormData.fromMap(map, ListFormat.multiCompatible);

      final response = await _dio.dio.post(requestPath, data: formData);
      return ResponseModel.fromModel(BuildingModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<BuildingModel>?> updateBuilding({
    required String id,
    required String name,
    required String address,
    String? description,
    required double latitude,
    required double longitude,
    required int floorCount,
    bool isActive = true,
    List<String>? imagePaths,
  }) async {
    try {
      final Map<String, dynamic> map = {
        'id': id,
        'name': name,
        'address': address,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'floorCount': floorCount,
        'isActive': isActive,
      };

      if (imagePaths != null && imagePaths.isNotEmpty) {
        map['images'] = [
          for (String path in imagePaths) await MultipartFile.fromFile(path),
        ];
      }

      final formData = FormData.fromMap(map, ListFormat.multiCompatible);

      final response = await _dio.dio.put(requestPath, data: formData);
      return ResponseModel.fromModel(BuildingModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<BuildingModel>?> updateActive({
    required String id,
    required bool isActive,
  }) async {
    try {
      final response = await _dio.dio.patch(
        '$requestPath/$id',
        queryParameters: {'active': isActive},
      );
      return ResponseModel.fromModel(BuildingModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<List<LocationModel>>?> getAllBuildings() async {
    try {
      final response = await _dio.dio.get(requestPath);
      return ResponseModel.fromList(LocationModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<BuildingModel?>?> getBuildingById({
    required String id,
  }) async {
    try {
      final response = await _dio.dio.get('$requestPath/$id');
      return ResponseModel.fromModel<BuildingModel?>(
        BuildingModel.fromModel,
        response.data,
      );
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    } catch (e) {
      debugPrint("Error $e");
    }
    return null;
  }

  Future<ResponseModel<bool>?> deleteBuilding({required String id}) async {
    try {
      final response = await _dio.dio.delete('$requestPath/$id');
      return ResponseModel.fromRaw(response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
