import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../screens/home/home.dart';
import '../strings/strings_en.dart';

class UserStateProvider with ChangeNotifier {

  final db = FirebaseFirestore.instance;
  final _authentication = FirebaseAuth.instance;
  late CollectionReference userInfo;
  var storage = const FlutterSecureStorage();

  String userUid = '';
  String userName = '';
  String userEmail = '';
  String userPassword = '';
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
      'signInTime' : DateTime.now(),
      'signOutTime' : DateTime.now(),
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
  Future<bool> signIn(String email, String password, bool isAutoLogin) async {
    final newUser = await _authentication.signInWithEmailAndPassword(
        email: email,
        password: password
    );

    if (newUser.user != null) {
      userUid = newUser.user!.uid;

      // 사용자 정보 가져오기
      await getUserInfo(userUid);

      // 자동 로그인 체크 박스 체크를 했다면, storage 에 사용자 정보 저장
      if( isAutoLogin ) {
        await storage.write(key: userUid, value: 'STATUS_LOGIN');
      }

      isLogged = true;
    }

    return isLogged;
  }



  // 로그아웃
  Future<bool> signOut() async{
    try {
      await _authentication.signOut();
      await userInfo.doc(userUid).update({
        'signOutTime' : DateTime.now()
      });

      Map<String, String> allValues = await storage.readAll();
      if( allValues != null ) {
        allValues.forEach((key, value) async {

          if( value == 'STATUS_LOGIN' ) {
            await storage.write(key: userUid, value: 'STATUS_LOGOUT');
          }
        });
      }
      return true;

    } catch(e) {
      print(e.toString());
    }
    return false;
  }


  // FlutterSecureStorage 에 저장된 정보 가져오기
  Future<void> getStorageInfo(BuildContext context) async {
    // Read all values
    Map<String, String> allValues = await storage.readAll();

    if( allValues != null ) {
      allValues.forEach((key, value) {

        if( value == 'STATUS_LOGIN' ) {
          userUid = key;
          getUserInfo(userUid);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home())
          );
        }
      });
    }
  }


  // 사용자 정보 가져오기
  Future<void> getUserInfo(String userUid) async {
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

    await userInfo.doc(userUid).update({
      'signInTime' : DateTime.now()
    });
  }
}