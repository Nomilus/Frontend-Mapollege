import 'package:application_mapollege/core/enum/role_enum.dart';
import 'package:application_mapollege/core/model/people/user_model.dart';
import 'package:application_mapollege/core/service/dio_service.dart';
import 'package:application_mapollege/core/utility/error_utility.dart';
import 'package:application_mapollege/core/utility/response_utility.dart';
import 'package:dio/dio.dart';

class UserApi {
  UserApi(this._dio);

  final DioService _dio;
  final String requestPath = '/user';

  Future<ResponseUtility<UserModel>?> getProfile() async {
    try {
      final response = await _dio.dio.get('$requestPath/profile');
      return ResponseUtility.fromModel(UserModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<UserModel>?> getUserById({required String id}) async {
    try {
      final response = await _dio.dio.get('$requestPath/$id');
      return ResponseUtility.fromModel(UserModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<List<UserModel>>?> getAllUsers() async {
    try {
      final response = await _dio.dio.get(requestPath);
      return ResponseUtility.fromList(UserModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<UserModel>?> updateRole({
    required String id,
    required RoleEnum role,
  }) async {
    try {
      final response = await _dio.dio.patch(
        '$requestPath/$id',
        queryParameters: {"role": role.value},
      );
      return ResponseUtility.fromModel(UserModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<bool>?> deleteUser({required String id}) async {
    try {
      final response = await _dio.dio.delete('$requestPath/$id');
      return ResponseUtility.fromRaw(response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
