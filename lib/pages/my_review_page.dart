import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/component/my_review_list_widget.dart';
import 'package:project_dangoing/controller/user_controller.dart';
import 'package:project_dangoing/service/firebase_auth_service.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';


class MyReviewPage extends StatefulWidget {
  const MyReviewPage({super.key});

  @override
  State<MyReviewPage> createState() => _MyReviewPageState();
}

class _MyReviewPageState extends State<MyReviewPage> {
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  FontStyleManager fontStyleManager = FontStyleManager();
  UserController userController = Get.find();

  @override
  void initState() {
    userController.getGoogleUserModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
        builder: (userController) {
          return Scaffold(
              body: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery
                        .sizeOf(context)
                        .height * 0.15,
                    child: Center(child: Text("작성한 리뷰", style: TextStyle(
                        fontFamily: fontStyleManager.primaryFont,
                        fontSize: 22),)),
                  ),
                  SizedBox(
                    height: MediaQuery
                        .sizeOf(context)
                        .height * 0.85,
                    child: userController.myModel?.reviewList!.isEmpty??false
                    ? Center(child: Text("작성한 리뷰 없음", style: TextStyle(fontFamily: fontStyleManager.primarySecondFont, fontWeight: FontWeight.bold, fontSize: 22),))
                    : ListView.builder(
                        itemCount: userController.myModel?.reviewList?.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return MyReviewListWidget(review: userController.myModel!.reviewList![index], myModel: userController.myModel!,);
                        }),
                  )
                ],
              )
          );
        }
    );
  }
}
