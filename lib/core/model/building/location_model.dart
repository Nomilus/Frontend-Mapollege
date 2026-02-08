import 'package:mapollege/core/model/mix_model.dart';

class LocationModel implements MixLocationModel {
  @override
  final String id;
  @override
  final String name;
  @override
  final double latitude;
  @override
  final double longitude;

  LocationModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromModel(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      latitude: json['latitude'] as double? ?? 0.0,
      longitude: json['longitude'] as double? ?? 0.0,
    );
  }
}
