import 'package:application_mapollege/core/model/people/token_model.dart';
import 'package:application_mapollege/core/service/dio_service.dart';
import 'package:application_mapollege/core/utility/error_utility.dart';
import 'package:application_mapollege/core/utility/response_utility.dart';
import 'package:dio/dio.dart';

class AuthApi {
  AuthApi(this._dio);

  final DioService _dio;
  final String requestPath = '/auth';

  Future<ResponseUtility<TokenModel>?> verifyToken({
    required String firebaseToken,
  }) async {
    try {
      final response = await _dio.dio.post(
        '$requestPath/verify',
        data: {"token": firebaseToken},
      );
      return ResponseUtility.fromModel(TokenModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<TokenModel>?> refreshToken({
    required String refreshToken,
  }) async {    
    try {
      final response = await _dio.dio.post(
        '$requestPath/refresh',
        data: {"token": refreshToken},
      );
      return ResponseUtility.fromModel(TokenModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
