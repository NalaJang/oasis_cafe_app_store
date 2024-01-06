import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/model_phoneNumber.dart';

class PhoneNumberProvider with ChangeNotifier {
  static const String phoneNumberDocName = 'phoneNumberDoc';

  late DocumentReference phoneNumberReference;
  final db = FirebaseFirestore.instance;
  var isChecked = false;
  var isUpdated = false;
  String number1 = '';
  String number2 = '';
  String number3 = '';


  PhoneNumberProvider() {
    phoneNumberReference = db.collection('aboutUs').doc(phoneNumberDocName);
  }


  // 전화번호 가져오기
  Future<void> getPhoneNumber() async {
    await phoneNumberReference.get().then(
          (DocumentSnapshot doc) {
            if( doc.data() != null) {
              number1 = PhoneNumberModel.getSnapshotData(doc).number1;
              number2 = PhoneNumberModel.getSnapshotData(doc).number2;
              number3 = PhoneNumberModel.getSnapshotData(doc).number3;
            }
          },

      onError: (e) => print("Error completing: $e"),
    );

    if( number1 != '' ) {
      isChecked = true;
    }

    notifyListeners();
  }


  // 전화번호 저장
  Future<bool> updatePhoneNumber(String number1, String number2, String number3) async {
    try {
      await phoneNumberReference.update({
        'number1' : number1,
        'number2' : number2,
        'number3' : number3,
      });
      isUpdated = true;

    } catch(e) {
      print(e);
      isUpdated = false;
    }
    return isUpdated;
  }
}