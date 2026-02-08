import 'package:flutter/foundation.dart';
import 'package:mapollege/core/model/pageable_model.dart';
import 'package:mapollege/core/utility/parse_utility.dart';

class ResponseModel<T> {
  final String title;
  final DateTime? createdAt;
  final T data;

  ResponseModel({
    required this.title,
    required this.createdAt,
    required this.data,
  });

  static Future<ResponseModel<T>> fromModel<T>(
    T Function(Map<String, dynamic>) parser,
    dynamic json,
  ) async {
    return ResponseModel<T>(
      title: json['title'] as String? ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      data: await compute(ParseUtility.parseModel<T>, {
        'parser': parser,
        'data': json['data'],
      }),
    );
  }

  static ResponseModel<T> fromRaw<T>(Map<String, dynamic> json) {
    return ResponseModel<T>(
      title: json['title'] as String,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      data: json['data'] as T,
    );
  }

  static Future<ResponseModel<List<T>>> fromList<T>(
    T Function(Map<String, dynamic>) parser,
    Map<String, dynamic> json,
  ) async {
    final rawList = json['data'] as List? ?? [];

    return ResponseModel<List<T>>(
      title: json['title'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      data: await compute(ParseUtility.parseList<T>, {
        'parser': parser,
        'list': rawList,
      }),
    );
  }

  static Future<ResponseModel<PageableModel<T>>> fromPageable<T>(
    T Function(Map<String, dynamic>) parser,
    dynamic json,
  ) async {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final rawContent = data['content'] as List? ?? [];

    return ResponseModel<PageableModel<T>>(
      title: json['title'] as String? ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      data: PageableModel<T>(
        content: await compute(ParseUtility.parseList<T>, {
          'parser': parser,
          'list': rawContent,
        }),
        totalElements: data['totalElements'] as int? ?? 0,
        totalPages: data['totalPages'] as int? ?? 0,
        pageNumber: data['number'] as int? ?? 0,
        pageSize: data['size'] as int? ?? 0,
        last: data['last'] as bool? ?? false,
        first: data['first'] as bool? ?? false,
        empty: data['empty'] as bool? ?? false,
      ),
    );
  }
}
