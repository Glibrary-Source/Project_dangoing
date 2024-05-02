
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/user_controller.dart';
import '../utils/fontstyle_manager.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FontStyleManager fontStyleManager = FontStyleManager();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  String email = "";
  String password = "";
  String passwordConfirm = "";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/app_main_icon.png",
                      height: 50,
                      width: 50,
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "댕고잉",
                            style: TextStyle(
                              fontSize: 36
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.35,
                padding: const EdgeInsets.only(left: 36, right: 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: emailInputController,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(color: Colors.blueAccent)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          hintText: "이메일",
                          hintStyle: TextStyle(
                              color: CupertinoColors.systemGrey,
                              fontWeight: FontWeight.bold)),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: passwordInputController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.blueAccent)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        hintText: "비밀번호",
                        hintStyle: TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontWeight: FontWeight.bold),
                        focusColor: Colors.red,
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: passwordInputController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.blueAccent)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        hintText: "비밀번호 확인",
                        hintStyle: TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.30,
                padding: const EdgeInsets.only(left: 36, right: 36),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if(
                            email==""||
                            password==""||
                            passwordConfirm==""
                            ){
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('이메일과 패스워드를 바르게 입력해주세요')));
                            } else {
                              if(password!=passwordConfirm) {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('비밀번호를 확인하세요')));
                              }
                            }
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                              MaterialStatePropertyAll(Colors.blueAccent)),
                          child: const Padding(
                            padding: EdgeInsets.all(14),
                            child: Text(
                              "회원 가입",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.10,
                padding: const EdgeInsets.only(left: 36, right: 36),
                child: Column(
                  children: [
                    RichText(
                        text: const TextSpan(
                            text: "계속 진행하면 댕고잉의 ",
                            style: TextStyle(
                                color: CupertinoColors.systemGrey),
                            children: [
                              TextSpan(
                                  text: "서비스 약관 ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              TextSpan(
                                  text: "및 ",
                                  style: TextStyle(
                                      color: CupertinoColors.systemGrey)),
                              TextSpan(
                                  text: "개인정보 보호정책",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              TextSpan(
                                  text: "에 동의한 것으로 간주됩니다.",
                                  style: TextStyle(
                                      color: CupertinoColors.systemGrey)),
                            ]))
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
