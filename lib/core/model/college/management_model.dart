import 'package:mapollege/core/model/college/college_model.dart';
import 'package:mapollege/core/model/people/person_model.dart';
import 'package:mapollege/core/model/section/work_model.dart';

class ManagementModel {
  final String id;
  final String title;
  final CollegeModel college;
  final PersonModel deputyDirector;
  final DateTime createdAt;
  final DateTime updatedAt;
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
      id: json['id'] as String,
      title: json['title'] as String,
      college: CollegeModel.fromModel(json['college']),
      deputyDirector: PersonModel.fromModel(json['deputyDirector']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      works: (json['works'] as List? ?? [])
          .map<WorkModel>((item) => WorkModel.fromModel(item))
          .toList(),
    );
  }
}
