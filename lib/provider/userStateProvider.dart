import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../strings/strings_en.dart';

class UserStateProvider with ChangeNotifier {

  final db = FirebaseFirestore.instance;
  final _authentication = FirebaseAuth.instance;
  late CollectionReference userInfo;

  String userUid = '';
  String userName = '';
  String userEmail = '';
  String userDateOfBirth = '';
  String userMobileNumber = '';

  bool isSignedUp = false;
  bool isLogged = false;

  UserStateProvider() {
    userInfo = db.collection(Strings.collection_admin);
  }

  // 회원가입
  Future<bool> signUp(String email, String password, String name, String mobileNumber) async {
    final newUser = await _authentication.createUserWithEmailAndPassword(
        email: email, password: password);

    await userInfo
        .doc(newUser.user!.uid)
        .set({
      // 데이터의 형식은 항상 map 의 형태
      'signUpTime' : DateTime.now(),
      'userEmail' : email,
      'userPassword' : password,
      'userName' : name,
      'userMobileNumber' : mobileNumber,
    });

    if( newUser.user != null ) {
      isSignedUp = true;
    }

    return isSignedUp;
  }

  // 로그인
  Future<bool> signIn(String email, String password) async {
    final newUser = await _authentication.signInWithEmailAndPassword(
        email: email,
        password: password
    );

    if (newUser.user != null) {
      userUid = newUser.user!.uid;

      await userInfo
          .doc(userUid)
          .get()
          .then((value) =>
      {

        // value.data()!['userName'] -> value['userName'] can be replaced
        // In the new flutter update, we don't need to add .data()
        userName = value['userName'],
        userEmail = value['userEmail'],
        userMobileNumber = value['userMobileNumber'],
      });
    }

    if (newUser.user != null) {
      isLogged = true;
    }

    return isLogged;
  }
}