import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_dangoing/service/dango_firebase_service.dart';
import 'package:project_dangoing/vo/user_vo.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference userCollection = firestore.collection('user_db');

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    // 구글 로그인
    GoogleSignInAccount? account = await googleSignIn.signIn();
    if (account == null) {
      return null;
    }

    // 토큰 및 인증 정보
    GoogleSignInAuthentication authentication = await account.authentication;
    OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken
    );

    // 로그인 시도
    try {
      UserCredential userCredential = await auth.signInWithCredential(credential);
      addFirebaseUser(userCredential);
      return userCredential;
    } on FirebaseAuthException catch(e) {
      if(context.mounted) {
        showSnackBar(context);
      }
      return null;
    }
  }

  void addFirebaseUser(UserCredential userCredential) async {
    String? userUid = userCredential.user?.uid;

    UserVo userVo = UserVo(
      uid: userUid,
      email: userCredential.user?.email,
      change_counter: false,
      nickname: "기본 닉네임"
    );

    await userCollection.doc(userUid).set(userVo.toMap());
  }

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("로그인에 실패하였습니다")),
    );
  }
}