import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/review_controller.dart';
import 'package:project_dangoing/controller/user_controller.dart';
import 'package:project_dangoing/pages/my_review_page.dart';
import 'package:project_dangoing/service/dango_firebase_service.dart';
import 'package:project_dangoing/service/firebase_auth_service.dart';
import 'package:project_dangoing/theme/colors.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  TextEditingController nickNameChangeInputController = TextEditingController();
  String nickName = "";

  FontStyleManager fontStyleManager = FontStyleManager();
  bool nickNameChange = false;

  final authService = FirebaseAuthService();

  var lastPopTime;

  void handleGoogleLogin() async {
    await authService.signInWithGoogle(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        final now = DateTime.now();
        if (lastPopTime == null ||
            now.difference(lastPopTime) > Duration(seconds: 2)) {
          lastPopTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('뒤로 버튼을 한 번 더 누르면 앱이 종료됩니다.'),
            ),
          );
          return;
        } else {
          // 두 번 연속으로 뒤로가기 버튼을 누르면 앱 종료
          exit(0);
        }
      },
      child: GetBuilder<UserController>(builder: (userController) {
        return Scaffold(
          body: SingleChildScrollView(
            // child: userController.myInfo != null
            child: userController.myModel != null
                ? Container(
                    height: MediaQuery.sizeOf(context).height*0.92,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.35,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/dangoing_logo.png",
                                  height: 80,
                                  width: 80,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "댕고잉",
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontFamily:
                                            fontStyleManager.getPrimaryFont(),
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text(
                              // "Email: ${userController.myInfo?.email}",
                              "Email: ${userController.myModel?.email}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily:
                                      fontStyleManager.getPrimarySecondFont(),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 8, top: 4),
                                child: Text(
                                  // "닉네임: ${userController.myInfo?.nickname}",
                                  "닉네임: ${userController.myModel?.nickname}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: fontStyleManager
                                          .getPrimarySecondFont(),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      nickNameChange = !nickNameChange;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: dangoingMainColor,
                                  ))
                            ],
                          ),
                          nickNameChange == false
                              ? SizedBox()
                              : Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller:
                                            nickNameChangeInputController,
                                        inputFormatters: [
                                          FilteringTextInputFormatter(
                                            RegExp('[a-z A-Z ㄱ-ㅎ|가-힣|·|：]'),
                                            allow: true,
                                          )
                                        ],
                                        onChanged: (value) {
                                          nickName = value;
                                          if (nickName.length >= 10) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "10자 이하로 작성해주세요.")));
                                          }
                                        },
                                        maxLength: 10,
                                        decoration:
                                            InputDecoration(counterText: ''),
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (nickName == "") {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        '닉네임을 바르게 작성해주세요')));
                                          } else {
                                            // if (userController.myInfo!.change_counter!) {
                                            //   ScaffoldMessenger.of(context)
                                            //       .showSnackBar(SnackBar(
                                            //           content: Text(
                                            //               '닉네임을 이미 변경하신 회원입니다.')));
                                            if (userController.myModel!.change_counter!) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                  content: Text(
                                                      '닉네임을 이미 변경하신 회원입니다.')));
                                            } else {
                                              userController
                                                  .userNickNameChange(nickName);
                                            }
                                          }
                                          setState(() {
                                            nickNameChange = false;
                                            nickNameChangeInputController
                                                .clear();
                                          });
                                        },
                                        child: Text("변경"))
                                  ],
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Get.to(() => MyReviewPage());
                              },
                              child: Text("내가쓴 리뷰 보기")),
                          Spacer(),
                          ElevatedButton(
                              onPressed: () {
                                userController.googleLogout();
                              },
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "로그아웃",
                                    textAlign: TextAlign.center,
                                  ))),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
              height: MediaQuery.sizeOf(context).height*0.91,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/dangoing_logo.png",
                              height: 80,
                              width: 80,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "댕고잉",
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontFamily:
                                          fontStyleManager.getPrimaryFont(),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Column(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () async {
                                await userController.googleLogin(context);
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white)),
                              icon: Image.asset("assets/icons/google.png",
                                  height: 40, width: 40),
                              label: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16, bottom: 16),
                                child: Text(
                                  "구글 로그인",
                                  style: TextStyle(
                                      fontFamily:
                                          fontStyleManager.getPrimarySecondFont(),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ),
          ),
        );
      }),
    );
  }
}
