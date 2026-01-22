import 'package:mapollege/config/const/permission.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mapollege/config/const/register.dart';
import 'package:mapollege/config/router/admin_router.dart';
import 'package:mapollege/config/router/private_router.dart';
import 'package:mapollege/config/router/public_router.dart';
import 'package:mapollege/config/router/routes.dart';
import 'package:mapollege/config/theme/app_theme.dart';
import 'package:mapollege/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Register().init;
  runApp(const MainApp());
}

class MainService extends GetxService {
  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  Future<void> _initialize() async {
    await Permission().init;
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainService(), permanent: true);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      theme: ThemeApp().getLightTheme,
      darkTheme: ThemeApp().getDarkTheme,
      themeMode: ThemeMode.system,
      getPages: [
        ...AdminRouter().init,
        ...PrivateRouter().init,
        ...PublicRouter().init,
      ],
      initialRoute: Routes.public.home,
    );
  }
}
