import 'package:mapollege/core/enum/role_enum.dart';
import 'package:dio/dio.dart';
import 'package:mapollege/core/model/people/user_model.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/utility/error_utility.dart';
import 'package:mapollege/core/model/response_model.dart';

class UserApi {
  UserApi(this._dio);

  final DioService _dio;
  final String requestPath = '/user';

  Future<ResponseModel<UserModel>?> getProfile() async {
    try {
      final response = await _dio.dio.get('$requestPath/profile');
      return ResponseModel.fromModel(UserModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<UserModel>?> getUserById({required String id}) async {
    try {
      final response = await _dio.dio.get('$requestPath/$id');
      return ResponseModel.fromModel(UserModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<List<UserModel>>?> getAllUsers() async {
    try {
      final response = await _dio.dio.get(requestPath);
      return ResponseModel.fromList(UserModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<UserModel>?> updateRole({
    required String id,
    required RoleEnum role,
  }) async {
    try {
      final response = await _dio.dio.patch(
        '$requestPath/$id',
        queryParameters: {"role": role.value},
      );
      return ResponseModel.fromModel(UserModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<bool>?> deleteUser({required String id}) async {
    try {
      final response = await _dio.dio.delete('$requestPath/$id');
      return ResponseModel.fromRaw(response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
