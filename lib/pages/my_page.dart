import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/user_controller.dart';
import 'package:project_dangoing/service/firebase_auth_service.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  FontStyleManager fontStyleManager = FontStyleManager();

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
    return GetBuilder<UserController>(builder: (controller) {
      return Scaffold(
        body: controller.myInfo != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("이메일 ${controller.myInfo?.email}"),
                  Text("UID ${controller.myInfo?.uid}"),
                  Text("NICKNAME ${controller.myInfo?.nickname}"),
                  Text("CHANGECOUNTER ${controller.myInfo?.change_counter}"),
                ],
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
                          await controller.googleLogin(context);
                          await controller.getGoogleUserVo();
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
