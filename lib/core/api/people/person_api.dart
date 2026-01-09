import 'package:application_mapollege/core/model/people/person_model.dart';
import 'package:application_mapollege/core/service/dio_service.dart';
import 'package:application_mapollege/core/utility/error_utility.dart';
import 'package:application_mapollege/core/utility/response_utility.dart';
import 'package:dio/dio.dart';

class PersonApi {
  PersonApi(this._dio);

  final DioService _dio;
  final String requestPath = '/college/person';

  Future<ResponseUtility<PersonModel>?> createPerson({
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

      return ResponseUtility.fromModel(PersonModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<PersonModel>?> updatePerson({
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

      return ResponseUtility.fromModel(PersonModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<List<PersonModel>>?> getPersonById({
    required String id,
  }) async {
    try {
      final response = await _dio.dio.get('$requestPath/$id');
      return ResponseUtility.fromList(PersonModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<List<PersonModel>>?> getAllPerson() async {
    try {
      final response = await _dio.dio.get(requestPath);
      return ResponseUtility.fromList(PersonModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<bool>?> deletePerson({required String id}) async {
    try {
      final response = await _dio.dio.delete('$requestPath/$id');
      return ResponseUtility.fromRaw(response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
