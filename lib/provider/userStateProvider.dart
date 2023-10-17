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

  bool isLogged = false;

  UserStateProvider() {
    userInfo = db.collection(Strings.collection_admin);
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
        userDateOfBirth = value['userDateOfBirth'],
        userMobileNumber = value['userMobileNumber'],
      });
    }

    if (newUser.user != null) {
      isLogged = true;
    }

    return isLogged;
  }
}