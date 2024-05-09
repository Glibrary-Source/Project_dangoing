import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/location_controller.dart';
import 'package:project_dangoing/controller/review_controller.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/controller/user_controller.dart';
import 'package:project_dangoing/firebase_options.dart';
import 'package:project_dangoing/pages/splash_page.dart';
import 'package:project_dangoing/service/firebase_remote_config_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global/share_preference.dart';

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  await dotenv.load(fileName: ".env");
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  FirebaseRemoteConfigService().initRemoteConfig();

  FlutterNativeSplash.remove();

  prefs = await SharedPreferences.getInstance();
  prefs.setBool('firstLaunch', true);

  Get.put(StoreController());
  Get.put(UserController());
  Get.put(ReviewController());
  Get.put(LocationController());

  await NaverMapSdk.instance.initialize(clientId: dotenv.env['naverMapClientId']);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Suit'
      ),
      home: const SplashPage() ,
    );
  }
}