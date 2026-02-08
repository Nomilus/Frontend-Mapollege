import 'package:mapollege/core/model/building/building_model.dart';
import 'package:mapollege/core/model/building/room_model.dart';
import 'package:mapollege/core/model/people/notification_model.dart';
import 'package:mapollege/core/model/people/person_model.dart';
import 'package:mapollege/core/model/people/user_model.dart';
import 'package:mapollege/core/model/section/department_model.dart';
import 'package:mapollege/core/model/section/work_model.dart';

enum TableEnum {
  user('user', UserModel.fromModel),
  notification('notification', NotificationModel.fromModel),
  building('building', BuildingModel.fromModel),
  room('room', RoomModel.fromModel),
  person('person', PersonModel.fromModel),
  department('department', DepartmentModel.fromModel),
  work('work', WorkModel.fromModel);

  const TableEnum(this.value, this.parser);
  final String value;
  final Object Function(Map<String, dynamic>) parser;
}
