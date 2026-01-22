import 'package:dio/dio.dart';
import 'package:mapollege/core/model/college/management_model.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/utility/error_utility.dart';
import 'package:mapollege/core/model/response_model.dart';

class ManagementApi {
  ManagementApi(this._dio);

  final DioService _dio;
  final String requestPath = '/college/management';

  Future<ResponseModel<ManagementModel>?> createManagement({
    required String title,
    required String collegeId,
    required String deputyDirectorId,
  }) async {
    try {
      final response = await _dio.dio.post(
        requestPath,
        data: {
          "title": title,
          "collegeId": collegeId,
          "deputyDirectorId": deputyDirectorId,
        },
      );

      return ResponseModel.fromModel(ManagementModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<ManagementModel>?> updateManagement({
    required String id,
    required String title,
    required String collegeId,
    required String deputyDirectorId,
  }) async {
    try {
      final response = await _dio.dio.put(
        requestPath,
        data: {
          "id": id,
          "title": title,
          "collegeId": collegeId,
          "deputyDirectorId": deputyDirectorId,
        },
      );

      return ResponseModel.fromModel(ManagementModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<ManagementModel>?> getManagementById({
    required String id,
  }) async {
    try {
      final response = await _dio.dio.get('$requestPath/$id');

      return ResponseModel.fromModel(ManagementModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<List<ManagementModel>>?> getAllManagement() async {
    try {
      final response = await _dio.dio.get(requestPath);

      return ResponseModel.fromList(ManagementModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<bool>?> deleteManagement({required String id}) async {
    try {
      final response = await _dio.dio.delete('$requestPath/$id');

      return ResponseModel.fromRaw(response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
