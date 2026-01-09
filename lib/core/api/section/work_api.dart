import 'package:application_mapollege/core/enum/work_enum.dart';
import 'package:application_mapollege/core/model/section/member_model.dart';
import 'package:application_mapollege/core/model/section/work_model.dart';
import 'package:application_mapollege/core/service/dio_service.dart';
import 'package:application_mapollege/core/utility/error_utility.dart';
import 'package:application_mapollege/core/utility/response_utility.dart';
import 'package:dio/dio.dart';

class WorkApi {
  WorkApi(this._dio);

  final DioService _dio;
  final String requestPath = '/work';

  Future<ResponseUtility<WorkModel>?> createWork({
    required String title,
    required String managementId,
  }) async {
    try {
      final response = await _dio.dio.post(
        requestPath,
        data: {"title": title, "managementId": managementId},
      );
      return ResponseUtility.fromModel(WorkModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<WorkModel>?> updateWork({
    required String id,
    required String title,
    required String managementId,
  }) async {
    try {
      final response = await _dio.dio.put(
        requestPath,
        data: {"id": id, "title": title, "managementId": managementId},
      );
      return ResponseUtility.fromModel(WorkModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<List<WorkModel>>?> getAllWork() async {
    try {
      final response = await _dio.dio.get(requestPath);
      return ResponseUtility<List<WorkModel>>.fromList(
        WorkModel.fromModel,
        response.data,
      );
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<WorkModel>?> getWorkById({required String id}) async {
    try {
      final response = await _dio.dio.get('$requestPath/$id');
      return ResponseUtility.fromModel(WorkModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<bool>?> deleteWork({required String id}) async {
    try {
      final response = await _dio.dio.delete('$requestPath/$id');
      return ResponseUtility.fromRaw(response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<WorkModel>?> addMember({
    required String workId,
    required SectionMember<WorkEnum> section,
  }) async {
    try {
      final response = await _dio.dio.put(
        '$requestPath/$workId/${section.personId}',
        data: {
          "positions": [
            for (WorkEnum position in section.positions) position.value,
          ],
        },
      );
      return ResponseUtility.fromModel(WorkModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<WorkModel>?> addListMember({
    required String workId,
    required List<SectionMember<WorkEnum>> sections,
  }) async {
    try {
      final response = await _dio.dio.put(
        '$requestPath/$workId',
        data: [
          for (SectionMember<WorkEnum> section in sections)
            {
              "id": workId,
              "personId": section.personId,
              "positions": [
                for (WorkEnum position in section.positions) position.value,
              ],
            },
        ],
      );
      return ResponseUtility.fromModel(WorkModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseUtility<bool>?> removeMember({
    required String workId,
    required String personId,
  }) async {
    try {
      final response = await _dio.dio.delete('$requestPath/$workId/$personId');
      return ResponseUtility<bool>.fromRaw(response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
