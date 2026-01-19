import 'package:mapollege/core/enum/department_enum.dart';
import 'package:mapollege/core/model/image_model.dart';
import 'package:mapollege/core/model/section/member_model.dart';

class DepartmentModel {
  final String id;
  final String title;
  final String website;
  final ImageModel image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<MemberModel<DepartmentEnum>> members;

  DepartmentModel({
    required this.id,
    required this.title,
    required this.website,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.members,
  });

  factory DepartmentModel.fromModel(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'] as String,
      title: json['title'] as String,
      website: json['website'] as String,
      image: ImageModel.fromModel(json['image']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      members: (json['members'] as List? ?? [])
          .map<MemberModel<DepartmentEnum>>(
            (item) =>
                MemberModel.fromModel(item, DepartmentEnum.unknown.fromValue),
          )
          .toList(),
    );
  }
}
