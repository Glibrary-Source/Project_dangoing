import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_dangoing/controller/user_controller.dart';
import 'package:project_dangoing/data/random_nick_name_data.dart';
import 'package:project_dangoing/model/user_model.dart';
import 'package:project_dangoing/service/dango_firebase_service.dart';
import 'package:project_dangoing/vo/user_vo.dart';

FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference userCollection = fireStore.collection('dangoing_user_db');
UserController userController = Get.find();
List<String> randomNickNameData = RandomNickNameData().nickName;

class FirebaseAuthService {

  Future<void> signInWithGoogle(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    Future.delayed(Duration(seconds: 10), (){userController.changeSignInState(false);});

    // 구글 로그인
    GoogleSignInAccount? account = await googleSignIn.signIn();
    if (account == null) {
      return;
    }

    // 토큰 및 인증 정보
    GoogleSignInAuthentication authentication = await account.authentication;
    OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken
    );

    // 로그인 시도
    try {
      userController.changeSignInState(true);
      UserCredential userCredential = await auth.signInWithCredential(credential);
      addFirebaseUser(userCredential);
    } on FirebaseAuthException catch(e) {
      if(context.mounted) {
        showSnackBar(context);
      }
      return;
    }
  }

  Future<void> addFirebaseUser(UserCredential userCredential) async {
    String? userUid = userCredential.user?.uid;

    UserVo userVo = UserVo(
      uid: userUid,
      email: userCredential.user?.email,
      change_counter: false,
      nickname: randomNickNameData[Random().nextInt(randomNickNameData.length)]
    );

    // 이미 db에 있는지 확인 이 절차가 없으면 로그인 할 때마다 기존데이터가 변경됨
    DocumentSnapshot querySnapshot = await userCollection.doc(userUid).get();
    if(querySnapshot.exists) {
      await userController.getGoogleUserModel();
      userController.changeSignInState(false);
      return;
    }

    await userCollection.doc(userUid).set(userVo.toMap()).then((value) {
      userController.getGoogleUserModel();
    });

    userController.changeSignInState(false);
  }

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("로그인에 실패하였습니다")),
    );
  }

  Future<UserModel?> getGoogleUserModel() async {
    try {
      if(auth.currentUser != null) {
        String? userUid = auth.currentUser?.uid;

        DocumentSnapshot documentSnapshot = await userCollection.doc(userUid).get();
        return UserModel.fromDocumentSnapShot(documentSnapshot);
      } else {
        return null;
      }
    } catch(error) {
      throw error;
    }
  }

  Future<UserModel?> googleLogout() async {
    try{
      GoogleSignIn().signOut();
      auth.signOut();
      return null;
    } catch(error) {
      throw error;
    }
  }

  Future<void> changeNickName(String nickname) async {
    try {
      final Map<String, dynamic> data = {};
      data['nickname'] = nickname;
      data['change_counter'] = true;
      userCollection.doc(auth.currentUser?.uid).update(
        data
      );
    } catch(error) {
      throw error;
    }
  }
}