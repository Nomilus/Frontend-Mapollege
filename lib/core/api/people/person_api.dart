import 'package:mapollege/core/model/people/person_model.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/utility/error_utility.dart';
import 'package:mapollege/core/model/response_model.dart';
import 'package:dio/dio.dart';

class PersonApi {
  PersonApi(this._dio);

  final DioService _dio;
  final String requestPath = '/college/person';

  Future<ResponseModel<PersonModel>?> createPerson({
    required String prefix,
    required String firstName,
    required String lastName,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'prefix': prefix,
        'firstName': firstName,
        'lastName': lastName,
        if (imagePath != null) 'image': await MultipartFile.fromFile(imagePath),
      });

      final response = await _dio.dio.post(requestPath, data: formData);

      return ResponseModel.fromModel(PersonModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<PersonModel>?> updatePerson({
    required String id,
    required String prefix,
    required String firstName,
    required String lastName,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'id': id,
        'prefix': prefix,
        'firstName': firstName,
        'lastName': lastName,
        if (imagePath != null) 'image': await MultipartFile.fromFile(imagePath),
      });

      final response = await _dio.dio.put(requestPath, data: formData);

      return ResponseModel.fromModel(PersonModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<List<PersonModel>>?> getPersonById({
    required String id,
  }) async {
    try {
      final response = await _dio.dio.get('$requestPath/$id');
      return ResponseModel.fromList(PersonModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<List<PersonModel>>?> getAllPerson() async {
    try {
      final response = await _dio.dio.get(requestPath);
      return ResponseModel.fromList(PersonModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<bool>?> deletePerson({required String id}) async {
    try {
      final response = await _dio.dio.delete('$requestPath/$id');
      return ResponseModel.fromRaw(response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
