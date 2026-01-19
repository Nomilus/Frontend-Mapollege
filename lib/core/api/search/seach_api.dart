import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/utility/error_utility.dart';
import 'package:mapollege/core/utility/response_utility.dart';
import 'package:dio/dio.dart';

class SeachApi<T> {
  SeachApi(this._dio);

  final DioService _dio;
  final String requestPath = '/search';

  Future<ResponseUtility<T>?> searchGeneral({
    String? search,
    String? table,
    int? page,
    int? size,
    String? sort,
    String? direction,
    required T Function(Map<String, dynamic>) parser,
  }) async {
    try {
      final Map<String, dynamic> map = {
        'search': search,
        'table': table,
        'page': page,
        'size': size,
        'sort': sort,
        'direction': direction,
      };

      final response = await _dio.dio.get(
        '$requestPath/general',
        queryParameters: map,
      );
      return ResponseUtility.fromList(parser, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<T>?> searchAdvanced({
    String? search,
    String? table,
    int? page,
    int? size,
    String? sort,
    String? direction,
    required T Function(Map<String, dynamic>) parser,
  }) async {
    try {
      final Map<String, dynamic> map = {
        'search': search,
        'table': table,
        'page': page,
        'size': size,
        'sort': sort,
        'direction': direction,
      };

      final response = await _dio.dio.get(
        '$requestPath/advanced',
        queryParameters: map,
      );
      return ResponseUtility.fromList(parser, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
