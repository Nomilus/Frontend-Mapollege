import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class ParseUtility {
  /// parser `T Function(Map<String, dynamic>)`
  ///
  /// list `List`
  static List<T> parseList<T>(Map<String, dynamic> params) {
    final parser = params['parser'] as T Function(Map<String, dynamic>);
    final list = params['list'] as List? ?? [];
    return list.map((e) => parser(e as Map<String, dynamic>)).toList();
  }

  /// parser `T Function(Map<String, dynamic>)`
  ///
  /// data `Map<String, dynamic>`
  static T parseModel<T>(Map<String, dynamic> params) {
    final parser = params['parser'] as T Function(Map<String, dynamic>);
    final data = params['data'] as Map<String, dynamic>? ?? {};
    return parser(data);
  }

  static List<List<double>> parsePoints(List<PointLatLng> points) {
    return points.map((p) => [p.latitude, p.longitude]).toList();
  }
}
