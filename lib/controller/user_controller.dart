
import 'package:get/get.dart';
import 'package:project_dangoing/service/dango_firebase_service.dart';
import 'package:project_dangoing/vo/user_vo.dart';

class UserController extends GetxController {


  final DangoFirebaseService dangoFirebaseService = DangoFirebaseService();

  UserVo? myInfo;


  ///유저등록(회원가입)
  Future<void> addUser(String email, String password) async {
    try{
      // await dangoFirebaseService.SignUpWithEmailAndPassword(email, password);
    } catch(error) {
      throw error;
    }
  }

  ///로그인 (이메일과 비번 직접작성 로그인)
  Future<void> login(String email, String password) async{

  }

  ///오토로그인
  Future<void> autoLogin() async {

  }

  /// 로그아웃
  Future<void> logout() async {

  }

  /// 내 유저정보 가져오기 ( 로그인과 상관없이 내 유저정보를 새로고침해서 다시들고오거나 할때사용)
  Future<void> getUser(String userUid) async {

  }

}