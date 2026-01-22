import 'package:mapollege/core/enum/department_enum.dart';
import 'package:mapollege/core/model/section/department_model.dart';
import 'package:mapollege/core/model/section/member_model.dart';
import 'package:mapollege/core/service/dio_service.dart';
import 'package:mapollege/core/utility/error_utility.dart';
import 'package:mapollege/core/model/response_model.dart';
import 'package:dio/dio.dart';

class DepartmentApi {
  DepartmentApi(this._dio);

  final DioService _dio;
  final String requestPath = '/college/department';

  Future<ResponseModel<DepartmentModel>?> createDepartment({
    required String title,
    String? website,
    String? logoPath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'title': title,
        'website': website,
        if (logoPath != null) 'logo': await MultipartFile.fromFile(logoPath),
      });

      final response = await _dio.dio.post(requestPath, data: formData);
      return ResponseModel.fromModel(DepartmentModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<DepartmentModel>?> updateDepartment({
    required String id,
    required String title,
    String? website,
    String? logoPath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'id': id,
        'title': title,
        'website': website,
        if (logoPath != null) 'logo': await MultipartFile.fromFile(logoPath),
      });

      final response = await _dio.dio.put(requestPath, data: formData);
      return ResponseModel.fromModel(DepartmentModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<List<DepartmentModel>>?> getAllDepartment() async {
    try {
      final response = await _dio.dio.get(requestPath);
      return ResponseModel.fromList(DepartmentModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<DepartmentModel>?> getDepartmentById({
    required String id,
  }) async {
    try {
      final response = await _dio.dio.get('$requestPath/$id');
      return ResponseModel.fromModel(DepartmentModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<bool>?> deleteDepartment({required String id}) async {
    try {
      final response = await _dio.dio.delete('$requestPath/$id');
      return ResponseModel.fromRaw(response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<DepartmentModel>?> addMember({
    required String departmentId,
    required SectionMember<DepartmentEnum> section,
  }) async {
    try {
      final response = await _dio.dio.put(
        '$requestPath/$departmentId/${section.personId}',
        data: {
          "positions": [
            for (DepartmentEnum position in section.positions) position.value,
          ],
        },
      );
      return ResponseModel.fromModel(DepartmentModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<DepartmentModel>?> addListMember({
    required String departmentId,
    required List<SectionMember<DepartmentEnum>> sections,
  }) async {
    try {
      final response = await _dio.dio.put(
        '$requestPath/$departmentId',
        data: [
          for (SectionMember<DepartmentEnum> section in sections)
            {
              "id": departmentId,
              "personId": section.personId,
              "positions": [
                for (DepartmentEnum position in section.positions)
                  position.value,
              ],
            },
        ],
      );
      return ResponseModel.fromModel(DepartmentModel.fromModel, response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }

  Future<ResponseModel<bool>?> removeMember({
    required String departmentId,
    required String personId,
  }) async {
    try {
      final response = await _dio.dio.delete(
        '$requestPath/$departmentId/$personId',
      );
      return ResponseModel.fromRaw<bool>(response.data);
    } on DioException catch (e) {
      ErrorUtility.handleDioException(e);
      return null;
    }
  }
}
