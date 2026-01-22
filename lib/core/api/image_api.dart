import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/utility/error_utility.dart';
import 'package:mapollege/core/model/response_model.dart';
import 'package:dio/dio.dart';

class ImageApi {
  ImageApi(this._dio);

  final DioService _dio;
  final String requestPath = '/image';

  Future<ResponseModel<bool>?> deleteImage({required String id}) async {
    try {
      final response = await _dio.dio.delete('$requestPath/$id');
      return ResponseModel.fromRaw(response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
