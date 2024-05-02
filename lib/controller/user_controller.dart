
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/model/user_model.dart';
import 'package:project_dangoing/service/dango_firebase_service.dart';
import 'package:project_dangoing/service/firebase_auth_service.dart';

class UserController extends GetxController {

  final FirebaseAuthService dangoingFirebaseUserService = FirebaseAuthService();
  final DangoFirebaseService dangoingFirebaseService = DangoFirebaseService();

  UserModel? myModel;
  bool signInIndicator = false;

  Future<void> googleLogin(BuildContext context) async {
    try{
      await dangoingFirebaseUserService.signInWithGoogle(context);
    } catch(error) {
      if(error is FirebaseAuthException) {
        if(error.code == 'user-not-found') {
          throw '계정 정보를 찾을 수 없습니다';
        }
      } else {
        rethrow;
      }
      rethrow;
    }
  }

  Future<void> getGoogleUserModel() async{
    try {
      myModel = await dangoingFirebaseUserService.getGoogleUserModel();
      update();
    } catch(error) {
      rethrow;
    }
  }

  Future<void> deleteReview(String docId, String uid) async {
    try {
      dangoingFirebaseService.deleteReviewTest(docId, uid);
      await dangoingFirebaseService.deleteUserReview(docId, uid);
      getGoogleUserModel();
    } catch(error) {
      rethrow;
    }
  }

  Future<void> googleLogout() async{
    try{
      myModel = await dangoingFirebaseUserService.googleLogout();
      update();
    } catch(error) {
      rethrow;
    }
  }

  Future<void> userNickNameChange(String nickName) async {
    try{
      await dangoingFirebaseUserService.changeNickName(nickName);
      getGoogleUserModel();
    } catch(error) {
      rethrow;
    }
  }

  Future<void> changeSignInState(bool state) async{
    signInIndicator = state;
    update();
  }

  Future<void> userDataDelete(String uid) async {
    try{
      await dangoingFirebaseService.deleteUser(uid);
      googleLogout();
    } catch(error) {
      rethrow;
    }
  }

}