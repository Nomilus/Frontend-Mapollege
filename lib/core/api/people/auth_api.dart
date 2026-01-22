import 'package:mapollege/core/model/people/token_model.dart';
import 'package:dio/dio.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/utility/error_utility.dart';
import 'package:mapollege/core/model/response_model.dart';

class AuthApi {
  AuthApi(this._dio);

  final DioService _dio;
  final String requestPath = '/auth';

  Future<ResponseModel<TokenModel>?> verifyToken({
    required String firebaseToken,
  }) async {
    try {
      final response = await _dio.dio.post(
        '$requestPath/verify',
        data: {"token": firebaseToken},
      );
      return ResponseModel.fromModel(TokenModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<TokenModel>?> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final response = await _dio.dio.post(
        '$requestPath/refresh',
        data: {"token": refreshToken},
      );
      return ResponseModel.fromModel(TokenModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
