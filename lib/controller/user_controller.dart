
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/model/user_model.dart';
import 'package:project_dangoing/service/firebase_auth_service.dart';
import 'package:project_dangoing/vo/user_vo.dart';

class UserController extends GetxController {

  final FirebaseAuthService dangoingFirebaseUserService = FirebaseAuthService();

  UserModel? myModel;

  Future<void> googleLogin(BuildContext context) async {
    try{
      await dangoingFirebaseUserService.signInWithGoogle(context);
    } catch(error) {
      if(error is FirebaseAuthException) {
        if(error.code == 'user-not-found') {
          throw '계정 정보를 찾을 수 없습니다';
        }
      } else {
        throw error;
      }
      throw error;
    }
  }

  Future<void> getGoogleUserModel() async{
    try {
      myModel = await dangoingFirebaseUserService.getGoogleUserModel();
      update();
    } catch(error) {
      throw error;
    }
  }

  Future<void> googleLogout() async{
    try{
      myModel = await dangoingFirebaseUserService.googleLogout();
      update();
    } catch(error) {
      throw error;
    }
  }

  Future<void> userNickNameChange(String nickName) async {
    try{
      await dangoingFirebaseUserService.changeNickName(nickName);
      getGoogleUserModel();
    } catch(error) {
      throw error;
    }
  }

}