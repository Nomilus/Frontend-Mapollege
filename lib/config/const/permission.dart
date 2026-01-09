import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';

class Permission {
  Future<void> get init async {
    await FirebaseMessaging.instance.requestPermission();
    await Geolocator.requestPermission();
  }
}
