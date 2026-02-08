import 'package:mapollege/core/enum/department_enum.dart';
import 'package:mapollege/core/model/image_model.dart';
import 'package:mapollege/core/model/mix_model.dart';
import 'package:mapollege/core/model/section/member_model.dart';

class DepartmentModel implements MixModel {
  @override
  final String id;
  @override
  final String title;
  final String website;
  final ImageModel? image;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
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
    final members = (json['members'] as List? ?? [])
        .map<MemberModel<DepartmentEnum>>(
          (item) =>
              MemberModel.fromModel(item, DepartmentEnum.unknown.fromValue),
        )
        .toList();

    members.sort((m1, m2) {
      final p1 = DepartmentEnum.unknown.fromPriority(m1.positions);
      final p2 = DepartmentEnum.unknown.fromPriority(m2.positions);

      return p1.compareTo(p2);
    });

    return DepartmentModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      website: json['website'] as String? ?? '',
      image: json['image'] != null ? ImageModel.fromModel(json['image']) : null,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? ''),
      members: members,
    );
  }
}
