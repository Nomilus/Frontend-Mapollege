class PageableModel<T> {
  final List<T> content;
  final int totalElements;
  final int totalPages;
  final int pageNumber;
  final int pageSize;
  final bool last;
  final bool first;
  final bool empty;

  PageableModel({
    required this.content,
    required this.totalElements,
    required this.totalPages,
    required this.pageNumber,
    required this.pageSize,
    required this.last,
    required this.first,
    required this.empty,
  });

  factory PageableModel.fromModel(
    T Function(Map<String, dynamic>) parser,
    Map<String, dynamic> json,
  ) {
    return PageableModel(
      content: (json['content'] as List? ?? [])
          .map((item) => parser(item as Map<String, dynamic>))
          .toList(),
      totalElements: json['totalElements'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
      pageNumber: json['number'] as int? ?? 0,
      pageSize: json['size'] as int? ?? 0,
      last: json['last'] as bool? ?? false,
      first: json['first'] as bool? ?? false,
      empty: json['empty'] as bool? ?? false,
    );
  }
}
