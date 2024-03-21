import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:project_dangoing/pages/main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), (){
      Get.off(()=> MainPage());
    });
    super.initState();
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
              style: TextStyle(fontSize: 34, color: Colors.black, fontFamily: 'JosefinSans-Bold'),
            )
          ],
        ),
    );
  }
}
