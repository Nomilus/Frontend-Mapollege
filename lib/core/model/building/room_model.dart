import 'package:mapollege/core/model/image_model.dart';
import 'package:mapollege/core/model/mix_model.dart';

class RoomModel implements MixModel {
  @override
  final String id;
  final String buildingId;
  final String roomName;
  final String roomNumber;
  final String description;
  final String floor;
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  final List<ImageModel> images;

  RoomModel({
    required this.id,
    required this.buildingId,
    required this.roomName,
    required this.roomNumber,
    required this.description,
    required this.floor,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  @override
  String get title =>
      "$roomName ${(roomNumber.isEmpty || roomNumber == '-') ? '' : "($roomNumber)"}";

  factory RoomModel.fromModel(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'] as String? ?? '',
      buildingId: json['buildingId'] as String? ?? '',
      roomName: json['roomName'] as String? ?? '',
      roomNumber: json['roomNumber'] as String? ?? '',
      description: json['description'] as String? ?? '',
      floor: json['floor'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? ''),
      images: (json['images'] as List? ?? [])
          .map<ImageModel>((item) => ImageModel.fromModel(item))
          .toList(),
    );
  }
}
