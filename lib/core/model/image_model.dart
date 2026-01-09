class ImageModel {
  final String id;
  final String url;
  final String fileName;
  final String fileType;
  final DateTime createdAt;
  final DateTime updatedAt;

  ImageModel({
    required this.id,
    required this.url,
    required this.fileName,
    required this.fileType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ImageModel.fromModel(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] as String,
      url: json['url'] as String,
      fileName: json['fileName'] as String,
      fileType: json['fileType'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
