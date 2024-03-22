
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../vo/user_vo.dart';
import 'dango_firebase_service.dart';

FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference userCollection = firestore.collection('user_db');

class DangoFirebaseUserService {

  Future<void> signUpWithEmailAndPassword(String userEmail, String userPassword) async {
    try {
      // 1. firebase auth 애 email과 password 등록
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword
      );

      // 2. 가입 성공 시 사용자의 UID 가져오기
      String? userUid = userCredential.user?.uid;

      // 3. userVo 인스턴스를 생성하는데 그 인스턴스의 멤버변수인 email에 userCredentail에서 이메일을 가져와 할당함.
      UserVo userVo = UserVo(
        email: userCredential.user!.email
      );
      // 4. add방식이 아닌 set으로 create를 함. set방식은 docId를 지정해줘야 하는데 2번에서 받은 userUid를 docId로 사용
      await userCollection.doc(userUid).set(userVo.toMap());

    } catch (error) {
      // 가입 실패 시 예외 처리
      if (error is FirebaseAuthException) {
        if (error.code == 'email-already-in-user') {
          throw '이미 가입되어있는 이메일 입니다.' ;
        }
      } else {
        throw error;
      }
    }
  }

}