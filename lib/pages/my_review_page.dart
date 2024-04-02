import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/user_controller.dart';
import 'package:project_dangoing/model/user_model.dart';
import 'package:project_dangoing/service/firebase_auth_service.dart';

import '../vo/reviewVo.dart';

class MyReviewPage extends StatefulWidget {
  const MyReviewPage({super.key});

  @override
  State<MyReviewPage> createState() => _MyReviewPageState();
}

class _MyReviewPageState extends State<MyReviewPage> {
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserController>(
        builder: (userController) {
          return ElevatedButton(onPressed: () async {
            userController.getGoogleUserModel();
            Future.delayed(Duration(seconds: 3), (){
              for(final doc in userController.myModel!.reviewList!) {
                print(doc.keys.first);
                print(doc.values.first.review_main);
              }
            });
          }, child: Text("테스트입니다"));
        }
      ),
    );
  }
}
