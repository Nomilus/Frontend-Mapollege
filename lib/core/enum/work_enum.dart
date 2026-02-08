import 'package:mapollege/core/model/section/member_model.dart';

enum WorkEnum implements Position {
  sectionHead('SECTION_HEAD', 'หัวหน้างาน', 1),
  officer('OFFICER', 'เจ้าหน้าที่', 2),
  assistant('ASSISTANT', 'ผู้ช่วยงาน', 3),
  unknown('UNKNOWN', 'ไม่ทราบ', 999);

  const WorkEnum(this.value, this.name, this.priority);

  @override
  final String value;

  @override
  final String name;

  @override
  final int priority;

  @override
  WorkEnum fromValue(String value) {
    return WorkEnum.values.firstWhere(
      (item) => item.value == value,
      orElse: () => WorkEnum.unknown,
    );
  }

  @override
  int fromPriority(List<Position?> position) {
    return position
        .map((e) => e?.priority ?? 999)
        .reduce((a, b) => a < b ? a : b);
  }
}
