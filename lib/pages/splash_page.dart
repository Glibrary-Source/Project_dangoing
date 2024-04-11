import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:project_dangoing/controller/user_controller.dart';
import 'package:project_dangoing/pages/home_page.dart';
import 'package:project_dangoing/pages/main_page.dart';
import 'package:project_dangoing/pages/main_page_tabbar.dart';

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
    Get.off(()=> MainPageTabbar());
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
          Text(
            textAlign: TextAlign.center,
            "Explore",
            style: TextStyle(
                fontSize: 34,
                color: Colors.black,
                fontFamily: 'JosefinSans-Bold'),
          )
        ],
      ),
    );
  }
}
