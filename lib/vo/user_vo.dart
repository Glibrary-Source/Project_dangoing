import 'package:cloud_firestore/cloud_firestore.dart';

class UserVo {
  String? uid;
  String? email;
  String? nickname;
  bool? change_counter;

  UserVo({
    this.uid,
    this.email,
    this.nickname,
    this.change_counter
  });

  UserVo.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    uid = documentSnapshot.id;
    email = documentSnapshot['email'];
    nickname = documentSnapshot['nickname'];
    change_counter = documentSnapshot['change_counter'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid??"";
    data['email'] = email??"";
    data['nickname'] = nickname??"";
    data['change_counter'] = change_counter??false;
    return data;
  }
}