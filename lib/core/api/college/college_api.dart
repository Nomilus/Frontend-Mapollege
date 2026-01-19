import 'package:dio/dio.dart';
import 'package:mapollege/core/model/college/college_model.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/utility/error_utility.dart';
import 'package:mapollege/core/utility/response_utility.dart';

class CollegeApi {
  CollegeApi(this._dio);

  final DioService _dio;
  final String requestPath = '/college';

  Future<ResponseUtility<CollegeModel>?> createCollege({
    required String name,
    required String address,
    String? description,
    required String directorId,
    required double latitude,
    required double longitude,
    String? website,
    String? logoPath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'address': address,
        'description': description,
        'director': directorId,
        'latitude': latitude,
        'longitude': longitude,
        'website': website,
        if (logoPath != null) 'logo': await MultipartFile.fromFile(logoPath),
      });

      final response = await _dio.dio.post(requestPath, data: formData);

      return ResponseUtility.fromModel(CollegeModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<CollegeModel>?> updateCollege({
    required String id,
    required String name,
    required String address,
    String? description,
    required String directorId,
    required double latitude,
    required double longitude,
    String? website,
    String? logoPath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'id': id,
        'name': name,
        'address': address,
        'description': description,
        'director': directorId,
        'latitude': latitude,
        'longitude': longitude,
        'website': website,
        if (logoPath != null) 'logo': await MultipartFile.fromFile(logoPath),
      });

      final response = await _dio.dio.put(requestPath, data: formData);

      return ResponseUtility.fromModel(CollegeModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<List<CollegeModel>>?> getAllCollege() async {
    try {
      final response = await _dio.dio.get(requestPath);

      return ResponseUtility<List<CollegeModel>>.fromList(
        CollegeModel.fromModel,
        response.data,
      );
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<CollegeModel>?> getCollegeById({
    required String id,
  }) async {
    try {
      final response = await _dio.dio.get('$requestPath/$id');

      return ResponseUtility.fromModel(CollegeModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<bool>?> deleteCollege({required String id}) async {
    try {
      final response = await _dio.dio.delete('$requestPath/$id');
      return ResponseUtility<bool>.fromRaw(response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
