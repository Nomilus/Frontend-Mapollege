import 'package:mapollege/core/model/building/room_model.dart';
import 'package:mapollege/core/model/image_model.dart';
import 'package:mapollege/core/model/mix_model.dart';
import 'package:mapollege/core/model/section/department_model.dart';
import 'package:mapollege/core/model/section/work_model.dart';

class BuildingModel implements MixModel {
  @override
  final String id;
  final String name;
  final String address;
  final String description;
  final double latitude;
  final double longitude;
  final int floorCount;
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  final List<ImageModel> images;
  final List<RoomModel> rooms;
  final List<DepartmentModel> departments;
  final List<WorkModel> works;

  BuildingModel({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.floorCount,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    required this.rooms,
    required this.departments,
    required this.works,
  });

  @override
  String get title => name;

  factory BuildingModel.fromModel(Map<String, dynamic> json) {
    final images = (json['images'] as List? ?? [])
        .map<ImageModel>((item) => ImageModel.fromModel(item))
        .toList();
    images.sort((a, b) => a.fileName.compareTo(b.fileName));

    final rooms = (json['rooms'] as List? ?? [])
        .map<RoomModel>((item) => RoomModel.fromModel(item))
        .toList();
    rooms.sort((a, b) {
      int floorCompare = a.floor.compareTo(b.floor);
      if (floorCompare != 0) return floorCompare;
      return a.roomNumber.compareTo(b.roomNumber);
    });

    final departments = (json['departments'] as List? ?? [])
        .map<DepartmentModel>((item) => DepartmentModel.fromModel(item))
        .toList();
    departments.sort((a, b) => a.title.compareTo(b.title));

    final works = (json['works'] as List? ?? [])
        .map<WorkModel>((item) => WorkModel.fromModel(item))
        .toList();
    works.sort((a, b) => a.title.compareTo(b.title));

    return BuildingModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      description: json['description'] as String? ?? '',
      latitude: json['latitude'] as double? ?? 0.0,
      longitude: json['longitude'] as double? ?? 0.0,
      floorCount: json['floorCount'] as int? ?? 0,
      isActive: json['isActive'] as bool? ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? ''),
      images: images,
      rooms: rooms,
      departments: departments,
      works: works,
    );
  }
}
