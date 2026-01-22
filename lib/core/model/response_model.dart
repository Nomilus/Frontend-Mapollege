import 'package:mapollege/core/model/pageable_model.dart';

class ResponseModel<T> {
  final String title;
  final DateTime? createdAt;
  final T data;

  ResponseModel({
    required this.title,
    required this.createdAt,
    required this.data,
  });

  static ResponseModel<T> fromModel<T>(
    T Function(Map<String, dynamic>) parser,
    dynamic json,
  ) {
    return ResponseModel<T>(
      title: json['title'] as String? ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      data: parser(json['data']),
    );
  }

  static ResponseModel<T> fromRaw<T>(Map<String, dynamic> json) {
    return ResponseModel<T>(
      title: json['title'] as String,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      data: json['data'] as T,
    );
  }

  static ResponseModel<List<T>> fromList<T>(
    T Function(Map<String, dynamic>) parser,
    Map<String, dynamic> json,
  ) {
    final rawList = json['data'] as List? ?? [];

    final listData = rawList
        .map((e) => parser(e as Map<String, dynamic>))
        .toList();

    return ResponseModel<List<T>>(
      title: json['title'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      data: listData,
    );
  }

  static ResponseModel<PageableModel<T>> fromPageable<T>(
    T Function(Map<String, dynamic>) parser,
    dynamic json,
  ) {
    return ResponseModel<PageableModel<T>>(
      title: json['title'] as String? ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      data: PageableModel.fromModel(parser, json['data']),
    );
  }
}
