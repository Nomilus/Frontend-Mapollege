import 'package:application_mapollege/core/model/image_model.dart';
import 'package:application_mapollege/core/model/building/room_model.dart';
import 'package:application_mapollege/core/model/section/department_model.dart';
import 'package:application_mapollege/core/model/section/work_model.dart';

class BuildingModel {
  final String id;
  final String name;
  final String address;
  final String description;
  final double latitude;
  final double longitude;
  final int floorCount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
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

  factory BuildingModel.fromModel(Map<String, dynamic> json) {
    return BuildingModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      floorCount: json['floorCount'] as int,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      images: (json['images'] as List? ?? [])
          .map<ImageModel>((item) => ImageModel.fromModel(item))
          .toList(),
      rooms: (json['rooms'] as List? ?? [])
          .map<RoomModel>((item) => RoomModel.fromModel(item))
          .toList(),
      departments: (json['departments'] as List? ?? [])
          .map<DepartmentModel>((item) => DepartmentModel.fromModel(item))
          .toList(),
      works: (json['works'] as List? ?? [])
          .map<WorkModel>((item) => WorkModel.fromModel(item))
          .toList(),
    );
  }
}
