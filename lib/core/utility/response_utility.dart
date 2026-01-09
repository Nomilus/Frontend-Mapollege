class ResponseUtility<T> {
  final String title;
  final DateTime createdAt;
  final T data;

  ResponseUtility({
    required this.title,
    required this.createdAt,
    required this.data,
  });

  factory ResponseUtility.fromModel(
    T Function(Map<String, dynamic>) parser,
    Map<String, dynamic> json,
  ) {
    return ResponseUtility<T>(
      title: json['title'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      data: parser(json['data'] as Map<String, dynamic>),
    );
  }

  factory ResponseUtility.fromRaw(Map<String, dynamic> json) {
    return ResponseUtility<T>(
      title: json['title'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      data: json['data'] as T,
    );
  }

  factory ResponseUtility.fromList(
    dynamic Function(Map<String, dynamic>) parser,
    Map<String, dynamic> json,
  ) {
    final listdata = (json['data'] as List)
        .map((item) => parser(item as Map<String, dynamic>))
        .toList();

    return ResponseUtility<T>(
      title: json['title'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      data: listdata as T,
    );
  }
}
