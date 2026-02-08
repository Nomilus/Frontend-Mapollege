abstract class MixModel {
  String get id;
  String get title;
  DateTime? get createdAt;
  DateTime? get updatedAt;
}

abstract class MixLocationModel {
  String get id;
  String get name;
  double get latitude;
  double get longitude;
}
