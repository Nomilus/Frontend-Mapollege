import 'package:mapollege/core/model/college/college_model.dart';
import 'package:mapollege/core/model/people/person_model.dart';
import 'package:mapollege/core/model/section/work_model.dart';

class ManagementModel {
  final String id;
  final String title;
  final CollegeModel college;
  final PersonModel deputyDirector;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<WorkModel> works;

  ManagementModel({
    required this.id,
    required this.title,
    required this.college,
    required this.deputyDirector,
    required this.createdAt,
    required this.updatedAt,
    required this.works,
  });

  factory ManagementModel.fromModel(Map<String, dynamic> json) {
    return ManagementModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      college: CollegeModel.fromModel(
        json['college'] as Map<String, dynamic>? ?? {},
      ),
      deputyDirector: PersonModel.fromModel(
        json['deputyDirector'] as Map<String, dynamic>? ?? {},
      ),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? ''),
      works: (json['works'] as List? ?? [])
          .map<WorkModel>((item) => WorkModel.fromModel(item))
          .toList(),
    );
  }
}
