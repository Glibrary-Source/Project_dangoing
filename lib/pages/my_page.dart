import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/user_controller.dart';
import 'package:project_dangoing/pages/my_review_page.dart';
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
  bool loginState = true;

  final authService = FirebaseAuthService();

  var lastPopTime;

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
            now.difference(lastPopTime) > const Duration(seconds: 2)) {
          lastPopTime = now;
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
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
            child: userController.myModel != null
                ? SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.92,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.1),
                          Image.asset(
                            "assets/logo/main_logo.png",
                            height: 150,
                            width: 200,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              "${userController.myModel?.email}",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 8, top: 4),
                                child: Text(
                                  "${userController.myModel?.nickname} 님",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                          fontStyleManager.weightRegular),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.08,
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    Get.to(() => const MyReviewPage());
                                  },
                                  splashRadius: 1,
                                  highlightColor: dangoingColorOrange500,
                                  style: IconButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  )),
                                  icon: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            const Icon(
                                              Icons.rate_review_outlined,
                                              size: 32,
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.only(bottom: 5),
                                                child: Text(
                                                  "남긴 리뷰",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          fontStyleManager
                                                              .weightRegular,
                                                      fontSize: 18,
                                                      height: 1),
                                                  textAlign: TextAlign.center,
                                                )),
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.arrow_forward_ios),
                                    ],
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              IconButton(
                                  onPressed: () async {
                                    if (userController
                                        .myModel!.change_counter!) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text('닉네임을 이미 변경하신 회원입니다.')));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text('닉네임변경은 1회 가능합니다.')));
                                      showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: ((context) {
                                            return AlertDialog(
                                              title: Text(
                                                "닉네임 변경",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: fontStyleManager
                                                        .weightRegular),
                                              ),
                                              surfaceTintColor: Colors.white,
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextField(
                                                    controller:
                                                        nickNameChangeInputController,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter(
                                                        RegExp(
                                                            '[a-z A-Z ㄱ-ㅎ|가-힣|·|：]'),
                                                        allow: true,
                                                      )
                                                    ],
                                                    onChanged: (value) {
                                                      nickName = value;
                                                    },
                                                    maxLength: 10,
                                                    decoration: const InputDecoration(
                                                        counterText: '',
                                                        hintText:
                                                            "닉네임을 작성해주세요"),
                                                  ),
                                                ],
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                    onPressed: () async {
                                                      if (nickName == "") {
                                                      } else {
                                                        userController
                                                            .userNickNameChange(
                                                                nickName);
                                                        Navigator.of(context)
                                                            .pop();
                                                      }

                                                      setState(() {
                                                        nickNameChange = false;
                                                        nickNameChangeInputController
                                                            .clear();
                                                        nickName = "";
                                                      });
                                                    },
                                                    child: Text(
                                                      "변경",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              fontStyleManager
                                                                  .weightRegular,
                                                          color:
                                                              dangoingColorOrange500),
                                                    )),
                                                Container(
                                                  child: TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                        "취소",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                fontStyleManager
                                                                    .weightRegular,
                                                            color:
                                                                dangoingColorOrange500),
                                                      )),
                                                ),
                                              ],
                                            );
                                          }));
                                    }
                                  },
                                  splashRadius: 1,
                                  highlightColor: dangoingColorOrange500,
                                  style: IconButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  )),
                                  icon: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            const Icon(
                                              Icons.edit_outlined,
                                              size: 32,
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.only(bottom: 5),
                                                child: Text(
                                                  "닉네임 변경하기",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          fontStyleManager
                                                              .weightRegular,
                                                      fontSize: 18,
                                                      height: 1),
                                                  textAlign: TextAlign.center,
                                                )),
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.arrow_forward_ios),
                                    ],
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              IconButton(
                                  onPressed: () async {
                                    userController.googleLogout();
                                  },
                                  splashRadius: 1,
                                  highlightColor: dangoingColorOrange500,
                                  style: IconButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  )),
                                  icon: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            const Icon(
                                              Icons.logout_outlined,
                                              size: 32,
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.only(bottom: 5),
                                                child: Text(
                                                  "로그아웃",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          fontStyleManager
                                                              .weightRegular,
                                                      fontSize: 18,
                                                      height: 1),
                                                  textAlign: TextAlign.center,
                                                )),
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.arrow_forward_ios),
                                    ],
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              IconButton(
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: ((context) {
                                          return AlertDialog(
                                            title: Text(
                                              "회원 탈퇴",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: fontStyleManager
                                                      .weightRegular),
                                            ),
                                            surfaceTintColor: Colors.white,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(8)),
                                            content: const Text("회원탈퇴를 진행 하시겠습니까?",),
                                            actions: <Widget>[
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop();
                                                  },
                                                  child: Text(
                                                    "취소",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        fontStyleManager
                                                            .weightRegular,
                                                        color:
                                                        dangoingColorOrange500),
                                                  )),
                                              Container(
                                                child: TextButton(
                                                    onPressed: () async {
                                                      await userController.userDataDelete(userController.myModel!.uid!);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "탈퇴",
                                                      style: TextStyle(
                                                          fontWeight:
                                                          fontStyleManager
                                                              .weightRegular,
                                                          color:
                                                          dangoingColorOrange500),
                                                    )),
                                              ),
                                            ],
                                          );
                                        }));
                                  },
                                  splashRadius: 1,
                                  highlightColor: dangoingColorOrange500,
                                  style: IconButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  )),
                                  icon: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            const Icon(
                                              Icons.delete_outline_outlined,
                                              size: 32,
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.only(bottom: 5),
                                                child: Text(
                                                  "회원 탈퇴",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          fontStyleManager
                                                              .weightRegular,
                                                      fontSize: 18,
                                                      height: 1),
                                                  textAlign: TextAlign.center,
                                                )),
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.arrow_forward_ios),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.80,
                        width: MediaQuery.sizeOf(context).width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/logo/main_logo.png",
                                  height: 220,
                                  width: 220,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 8, right: 8),
                              child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    await userController.googleLogin(context);
                                  },
                                  splashRadius: 1,
                                  highlightColor: dangoingColorOrange500,
                                  style: IconButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0))),
                                  icon: Image.asset(
                                    "assets/button/google_login_button.png",
                                    width: 350,
                                  )),
                            ),

                          ],
                        ),
                      ),
                      userController.signInIndicator
                          ? Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height,
                              decoration: BoxDecoration(
                                color:
                                    CupertinoColors.systemGrey.withOpacity(0.5),
                              ),
                              child: const Center(
                                  child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator())),
                            )
                          : const SizedBox()
                    ],
                  ),
          ),
        );
      }),
    );
  }
}
