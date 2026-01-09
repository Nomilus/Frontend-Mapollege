import 'package:application_mapollege/core/model/section/member_model.dart';

enum WorkEnum implements Position {
  sectionHead('SECTION_HEAD', 'หัวหน้างาน'),
  clericalStaff('CLERICAL_STAFF', 'สารบรรณฝ่าย'),
  officer('OFFICER', 'เจ้าหน้าที่'),
  assistant('ASSISTANT', 'ผู้ช่วยงาน'),
  unknown('UNKNOWN', 'ไม่ทราบ');

  const WorkEnum(this.value, this.name);

  @override
  final String value;

  @override
  final String name;

  @override
  WorkEnum fromValue(String value) {
    return WorkEnum.values.firstWhere(
      (item) => item.value == value,
      orElse: () => WorkEnum.unknown,
    );
  }
}
