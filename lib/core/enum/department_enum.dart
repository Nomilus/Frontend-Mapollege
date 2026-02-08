import 'package:mapollege/core/model/section/member_model.dart';

enum DepartmentEnum implements Position {
  departmentHead('DEPARTMENT_HEAD', 'หัวหน้าแผนก', 1),
  permanentTeacher('PERMANENT_TEACHER', 'ครูประจำ', 2),
  contractTeacher('CONTRACT_TEACHER', 'ครูอัตราจ้าง', 3),
  governmentTeacher('GOVERNMENT_TEACHER', 'พนักงานราชการ(สอน)', 4),
  unknown('UNKNOWN', 'ไม่ทราบ', 999);

  const DepartmentEnum(this.value, this.name, this.priority);

  @override
  final String value;

  @override
  final String name;

  @override
  final int priority;

  @override
  DepartmentEnum fromValue(String value) {
    return DepartmentEnum.values.firstWhere(
      (item) => item.value == value,
      orElse: () => DepartmentEnum.unknown,
    );
  }

  @override
  int fromPriority(List<Position?> position) {
    return position.map((e) => e?.priority ?? 999).reduce((a, b) => a < b ? a : b);
  }
}
