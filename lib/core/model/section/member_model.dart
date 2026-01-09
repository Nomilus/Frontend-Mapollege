import 'package:application_mapollege/core/model/image_model.dart';

abstract class Position<T extends Enum> {
  String get value;
  String get name;
  T fromValue(String value);
}

class MemberModel<T extends Position> {
  final String id;
  final String prefix;
  final String firstName;
  final String lastName;
  final ImageModel? image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<T> positions;

  MemberModel({
    required this.id,
    required this.prefix,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.positions,
  });

  factory MemberModel.fromModel(
    Map<String, dynamic> json,
    T Function(String) parser,
  ) {
    return MemberModel<T>(
      id: json['id'] as String,
      prefix: json['prefix'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      image: ImageModel.fromModel(json['image']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      positions: (json['positions'] as List? ?? [])
          .map<T>((item) => parser(item.toString()))
          .toList(),
    );
  }
}

class SectionMember<T extends Enum> {
  final String personId;
  final List<T> positions;

  SectionMember({required this.personId, required this.positions});
}
