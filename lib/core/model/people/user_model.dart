import 'package:mapollege/core/enum/role_enum.dart';
import 'package:mapollege/core/model/people/notification_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final RoleEnum role;
  final String picture;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<NotificationModel> notifications;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.picture,
    required this.createdAt,
    required this.updatedAt,
    required this.notifications,
  });

  factory UserModel.fromModel(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: RoleEnum.fromValue(json['role']),
      picture: json['picture'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      notifications: (json['notifications'] as List? ?? [])
          .map<NotificationModel>((item) => NotificationModel.fromModel(item))
          .toList(),
    );
  }
}
