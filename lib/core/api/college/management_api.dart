import 'package:dio/dio.dart';
import 'package:mapollege/core/model/college/management_model.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/utility/error_utility.dart';
import 'package:mapollege/core/utility/response_utility.dart';

class ManagementApi {
  ManagementApi(this._dio);

  final DioService _dio;
  final String requestPath = '/college/management';

  Future<ResponseUtility<ManagementModel>?> createManagement({
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

      return ResponseUtility.fromModel(
        ManagementModel.fromModel,
        response.data,
      );
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<ManagementModel>?> updateManagement({
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

      return ResponseUtility.fromModel(
        ManagementModel.fromModel,
        response.data,
      );
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<ManagementModel>?> getManagementById({
    required String id,
  }) async {
    try {
      final response = await _dio.dio.get('$requestPath/$id');

      return ResponseUtility.fromModel(
        ManagementModel.fromModel,
        response.data,
      );
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<List<ManagementModel>>?> getAllManagement() async {
    try {
      final response = await _dio.dio.get(requestPath);

      return ResponseUtility.fromList(ManagementModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<bool>?> deleteManagement({required String id}) async {
    try {
      final response = await _dio.dio.delete('$requestPath/$id');

      return ResponseUtility.fromRaw(response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
