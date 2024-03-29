import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/review_controller.dart';
import 'package:project_dangoing/controller/user_controller.dart';
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

  // TextEditingController emailInputController = TextEditingController();
  // TextEditingController passwordInputController = TextEditingController();
  // String email = "";
  // String password = "";
  final authService = FirebaseAuthService();

  void handleGoogleLogin() async {
    await authService.signInWithGoogle(context);
  }

  @override
  void dispose() {
    // emailInputController.dispose();
    // passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      return Scaffold(
        body: userController.myInfo != null
            ? Padding(
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
                                  fontFamily: fontStyleManager.getPrimaryFont(),
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
                        "Email: ${userController.myInfo?.email}",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: fontStyleManager.getPrimarySecondFont(),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Text(
                            "닉네임: ${userController.myInfo?.nickname}",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily:
                                    fontStyleManager.getPrimarySecondFont(),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              nickNameChange = !nickNameChange;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 7),
                            child: Icon(Icons.edit),
                          ),
                        ),
                      ],
                    ),
                    nickNameChange == false
                        ? SizedBox()
                        : Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: nickNameChangeInputController,
                                  onChanged: (value) {
                                    nickName = value;
                                  },
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    if (nickName == "") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('닉네임을 바르게 작성해주세요')));
                                    } else {
                                      if (userController
                                          .myInfo!.change_counter!) {
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
                                      nickNameChangeInputController.clear();
                                    });
                                  },
                                  child: Text("변경"))
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
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
              )
            : Column(
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
                                fontFamily: fontStyleManager.getPrimaryFont(),
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
                          await userController.getGoogleUserVo();
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
      );
    });
  }

  /// email 있는 코드
// @override
// Widget build(BuildContext context) {
//   return GetBuilder<UserController>(builder: (controller) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: MediaQuery.sizeOf(context).height * 0.25,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     "assets/images/dangoing_logo.png",
//                     height: 50,
//                     width: 50,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           "댕고잉",
//                           style: TextStyle(
//                             fontSize: 36,
//                             fontFamily: fontStyleManager.getPrimaryFont(),
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: MediaQuery.sizeOf(context).height * 0.25,
//               padding: EdgeInsets.only(left: 36, right: 36),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   TextField(
//                     controller: emailInputController,
//                     decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(12)),
//                             borderSide: BorderSide(color: Colors.blueAccent)),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(12)),
//                         ),
//                         hintText: "이메일",
//                         hintStyle: TextStyle(
//                             fontFamily:
//                                 fontStyleManager.getPrimarySecondFont(),
//                             fontWeight: FontWeight.bold)),
//                     onChanged: (value) {
//                       email = value;
//                     },
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   TextField(
//                     controller: passwordInputController,
//                     decoration: InputDecoration(
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(12)),
//                           borderSide: BorderSide(color: Colors.blueAccent)),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(12)),
//                       ),
//                       hintText: "비밀번호",
//                       hintStyle: TextStyle(
//                           fontFamily: fontStyleManager.getPrimarySecondFont(),
//                           fontWeight: FontWeight.bold),
//                       focusColor: Colors.red,
//                     ),
//                     onChanged: (value) {
//                       password = value;
//                     },
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               height: MediaQuery.sizeOf(context).height * 0.30,
//               padding: EdgeInsets.only(left: 36, right: 36),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                         onPressed: () {},
//                         style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStatePropertyAll(Colors.redAccent)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(14),
//                           child: Text(
//                             "로그인",
//                             style: TextStyle(
//                                 fontFamily:
//                                     fontStyleManager.getPrimarySecondFont(),
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                         )),
//                   ),
//                   SizedBox(
//                     height: 60,
//                     child: Center(
//                         child: Text(
//                       "또는",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontFamily:
//                               fontStyleManager.getPrimarySecondFont()),
//                     )),
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                         onPressed: () {
//                           Get.to(()=>SignUpPage());
//                         },
//                         style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStatePropertyAll(Colors.blueAccent)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(14),
//                           child: Text(
//                             "회원 가입",
//                             style: TextStyle(
//                                 fontFamily:
//                                     fontStyleManager.getPrimarySecondFont(),
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                         )),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton.icon(
//                       onPressed: () {},
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStatePropertyAll(Colors.white)),
//                       icon: Image.asset("assets/icons/google.png",
//                           height: 40, width: 40),
//                       label: Padding(
//                         padding: const EdgeInsets.all(14),
//                         child: Text(
//                           "구글 로그인",
//                           style: TextStyle(
//                               fontFamily:
//                                   fontStyleManager.getPrimarySecondFont(),
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: MediaQuery.sizeOf(context).height * 0.10,
//               padding: EdgeInsets.only(left: 36, right: 36),
//               child: Column(
//                 children: [
//                   SizedBox(height: 10,),
//                   RichText(
//                       text: TextSpan(
//                           text: "계속 진행하면 댕고잉의 ",
//                           style: TextStyle(
//                               fontFamily:
//                                   fontStyleManager.getPrimarySecondFont(),
//                               color: CupertinoColors.systemGrey),
//                           children: [
//                         TextSpan(
//                             text: "서비스 약관 ",
//                             style: TextStyle(
//                                 fontFamily:
//                                     fontStyleManager.getPrimarySecondFont(),
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black)),
//                         TextSpan(
//                             text: "및 ",
//                             style: TextStyle(
//                                 fontFamily:
//                                     fontStyleManager.getPrimarySecondFont(),
//                                 color: CupertinoColors.systemGrey)),
//                         TextSpan(
//                             text: "개인정보 보호정책",
//                             style: TextStyle(
//                                 fontFamily:
//                                     fontStyleManager.getPrimarySecondFont(),
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black)),
//                         TextSpan(
//                             text: "에 동의한 것으로 간주됩니다.",
//                             style: TextStyle(
//                                 fontFamily:
//                                     fontStyleManager.getPrimarySecondFont(),
//                                 color: CupertinoColors.systemGrey)),
//                       ]))
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   });
// }
}
