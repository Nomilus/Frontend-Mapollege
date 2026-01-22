import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';

class Permission {
  Future<void> get init async {
    final messaging = await FirebaseMessaging.instance.requestPermission();
    await Geolocator.requestPermission();

    if (messaging.authorizationStatus == AuthorizationStatus.authorized) {
      await FirebaseMessaging.instance.subscribeToTopic('all_users');
    }
  }
}
