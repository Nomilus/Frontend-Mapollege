import 'package:mapollege/core/model/pageable_model.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/utility/error_utility.dart';
import 'package:mapollege/core/model/response_model.dart';
import 'package:dio/dio.dart';

class SearchApi {
  SearchApi(this._dio);

  final DioService _dio;
  final String requestPath = '/search';

  Future<ResponseModel<PageableModel<T>>?> searchGeneral<T>({
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
      return ResponseModel.fromPageable(parser, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<PageableModel<T>>?> searchAdvanced<T>({
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
      return ResponseModel.fromPageable(parser, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
