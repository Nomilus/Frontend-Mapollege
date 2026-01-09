enum RoleEnum {
  user('ROLE_USER', 'ผู้ใช้งานทั่วไป'),
  admin('ROLE_ADMIN', 'ผู้ดูแลระบบ'),
  editor('ROLE_EDITOR', 'ผู้แก้ไขเนื้อหา'),
  superAdmin('ROLE_SUPERADMIN', 'ผู้ดูแลระบบสูงสุด');

  const RoleEnum(this.value, this.name);
  final String value;
  final String name;

  static RoleEnum fromValue(String value) {
    return RoleEnum.values.firstWhere(
      (item) => item.value == value,
      orElse: () => RoleEnum.user,
    );
  }
}
