import 'package:application_mapollege/core/model/image_model.dart';

class PersonModel {
  final String id;
  final String prefix;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ImageModel image;

  PersonModel({
    required this.id,
    required this.prefix,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  factory PersonModel.fromModel(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'] as String,
      prefix: json['prefix'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      image: ImageModel.fromModel(json['image']),
    );
  }
}
