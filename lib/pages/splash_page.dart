import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:project_dangoing/controller/user_controller.dart';
import 'package:project_dangoing/pages/main_page_tabbar.dart';
import 'package:project_dangoing/service/firebase_remote_config_service.dart';

import '../controller/store_controller.dart';
import '../global/share_preference.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  StoreController storeController = Get.find();
  UserController userController = Get.find();
  String local = prefs.getString("local") ?? "서울특별시";

  @override
  void initState() {
    _fetchData();
    userController.getGoogleUserModel();

    super.initState();
  }

  Future<void> _fetchData() async {
    await storeController.getStoreAndRandomListSplash(local, context);
    checkVersionAndEmergency();
    storeController.setStoreLoadState(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lottie/walk_dog.json'),
          SizedBox(height: 60),
          Image.asset("assets/logo/main_logo.png", width: 150, height: 100,)
        ],
      ),
    );
  }

  Future<void> checkVersionAndEmergency() async {
    if(FirebaseRemoteConfigService().emergency??false) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: ((context) {
            return AlertDialog(
              title: Text(
                "긴급 업데이트",
              ),
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
              content: Text("어플리케이션 업데이트를 진행해주세요!",),
              actions: <Widget>[
                Container(
                  child: TextButton(
                      onPressed: () async {
                        exit(0);
                      },
                      child: Text(
                        "확인",
                      )),
                ),
              ],
            );
          }));
    } else {
      Get.off(()=> MainPageTabbar());
    }
  }

}