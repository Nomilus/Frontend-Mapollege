import 'package:mapollege/core/model/section/member_model.dart';

enum DepartmentEnum implements Position {
  departmentHead('DEPARTMENT_HEAD', 'หัวหน้าแผนก'),
  permanentTeacher('PERMANENT_TEACHER', 'ครูประจำ'),
  contractTeacher('CONTRACT_TEACHER', 'ครูอัตราจ้าง'),
  governmentTeacher('GOVERNMENT_TEACHER', 'พนักงานราชการ(สอน)'),
  unknown('UNKNOWN', 'ไม่ทราบ');

  const DepartmentEnum(this.value, this.name);

  @override
  final String value;

  @override
  final String name;

  @override
  DepartmentEnum fromValue(String value) {
    return DepartmentEnum.values.firstWhere(
      (item) => item.value == value,
      orElse: () => DepartmentEnum.unknown,
    );
  }
}
