import 'package:mapollege/core/model/college/management_model.dart';
import 'package:mapollege/core/model/image_model.dart';
import 'package:mapollege/core/model/mix_model.dart';
import 'package:mapollege/core/model/people/person_model.dart';

class CollegeModel implements MixLocationModel {
  @override
  final String id;
  @override
  final String name;
  final String address;
  final String description;
  final PersonModel director;
  @override
  final double latitude;
  @override
  final double longitude;
  final String website;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ManagementModel> managements;
  final List<ImageModel> images;

  CollegeModel({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.director,
    required this.latitude,
    required this.longitude,
    required this.website,
    required this.createdAt,
    required this.updatedAt,
    required this.managements,
    required this.images,
  });

  factory CollegeModel.fromModel(Map<String, dynamic> json) {
    return CollegeModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      description: json['description'] as String? ?? '',
      director: PersonModel.fromModel(
        json['director'] as Map<String, dynamic>? ?? {},
      ),
      latitude: json['latitude'] as double? ?? 0.0,
      longitude: json['longitude'] as double? ?? 0.0,
      website: json['website'] as String? ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? ''),
      managements: (json['managements'] as List? ?? [])
          .map<ManagementModel>((item) => ManagementModel.fromModel(item))
          .toList(),
      images: (json['images'] as List? ?? [])
          .map<ImageModel>((item) => ImageModel.fromModel(item))
          .toList(),
    );
  }
}
