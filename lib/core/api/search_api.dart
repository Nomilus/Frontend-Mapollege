import 'package:mapollege/core/enum/direction_enum.dart';
import 'package:mapollege/core/enum/sort_enum.dart';
import 'package:mapollege/core/enum/table_enum.dart';
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
    required String search,
    required TableEnum table,
    required int page,
    required int size,
    required T Function(Map<String, dynamic>) parser,
    SortEnum? sort,
    DirectionEnum? direction,
    CancelToken? cancelToken,
  }) async {
    try {
      final Map<String, dynamic> map = {
        'search': search,
        'table': table.value,
        'page': page,
        'size': size,
        'sort': sort?.value ?? SortEnum.createdAt.value,
        'direction': direction?.value ?? DirectionEnum.desc.value,
      };

      final response = await _dio.dio.get(
        '$requestPath/general',
        queryParameters: map,
        cancelToken: cancelToken,
      );
      return ResponseModel.fromPageable(parser, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<PageableModel<T>>?> searchAdvanced<T>({
    required String search,
    required TableEnum table,
    required int page,
    required int size,
    required T Function(Map<String, dynamic>) parser,
    SortEnum? sort,
    DirectionEnum? direction,
    CancelToken? cancelToken,
  }) async {
    try {
      final Map<String, dynamic> map = {
        'search': search,
        'table': table.value,
        'page': page,
        'size': size,
        'sort': sort?.value ?? SortEnum.createdAt.value,
        'direction': direction?.value ?? DirectionEnum.desc.value,
      };

      final response = await _dio.dio.get(
        '$requestPath/advanced',
        queryParameters: map,
        cancelToken: cancelToken,
      );
      return ResponseModel.fromPageable(parser, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
