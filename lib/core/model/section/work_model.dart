import 'package:mapollege/core/enum/work_enum.dart';
import 'package:mapollege/core/model/image_model.dart';
import 'package:mapollege/core/model/mix_model.dart';
import 'package:mapollege/core/model/section/member_model.dart';

class WorkModel implements MixModel {
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
  final List<MemberModel<WorkEnum>> members;

  WorkModel({
    required this.id,
    required this.title,
    required this.website,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.members,
  });

  factory WorkModel.fromModel(Map<String, dynamic> json) {
    final members = (json['members'] as List? ?? [])
        .map<MemberModel<WorkEnum>>(
          (item) => MemberModel.fromModel(item, WorkEnum.unknown.fromValue),
        )
        .toList();

    members.sort((m1, m2) {
      final p1 = WorkEnum.unknown.fromPriority(m1.positions);
      final p2 = WorkEnum.unknown.fromPriority(m2.positions);

      return p1.compareTo(p2);
    });

    return WorkModel(
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
