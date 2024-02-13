import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oasis_cafe_app_store/model/model_user.dart';
import 'package:oasis_cafe_app_store/provider/openingHoursProvider.dart';
import 'package:oasis_cafe_app_store/provider/phoneNumberController.dart';

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
  bool notification = false;

  bool isSignedUp = false;
  bool isFirstAdmin = false;
  bool isLogged = false;


  UserStateProvider() {
    userInfo = db.collection(Strings.collection_admin);
  }

  // 회원가입
  Future<bool> signUp(String email, String password, String name, String mobileNumber) async {
    final newUser = await _authentication.createUserWithEmailAndPassword(
        email: email, password: password);

    if( newUser.user != null ) {

      await userInfo
          .doc(newUser.user!.uid)
          .set(
              UserModel(name, email, password, mobileNumber).setData()
      );


      await firstAdmin();
      if( isFirstAdmin ) {
        OpeningHoursProvider().setOpeningHours();
        PhoneNumberController().setPhoneNumber();
      }

      isSignedUp = true;
    }

    return isSignedUp;
  }


  // 기존 가입자가 있었는 지 확인
  Future<void> firstAdmin() async {
    await userInfo.get().then((querySnapshot) {
      if( querySnapshot.docs.length == 1 ) {
        isFirstAdmin = true;
      }
    });
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
            // await storage.write(key: userUid, value: 'STATUS_LOGOUT');
            await storage.delete(key: userUid);
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
      notification = value['notification'],
    });

    await userInfo.doc(userUid).update({
      'signInTime' : DateTime.now()
    });
  }

  // 알람 설정 업데이트
  Future<void> updateAlarmSetting(String userUid, bool isSelected) async {
    await userInfo.doc(userUid).update({
      'notification' : isSelected,
    });

    notifyListeners();
  }

  // 계정 삭제
  Future<bool> deleteAccount() async {
    try {
      await _authentication.currentUser?.delete();
      await userInfo.doc(userUid).delete();
      return true;

    } catch(e) {
      print(e.toString());
    }

    return false;
  }
}