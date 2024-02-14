import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/model_phoneNumber.dart';

class PhoneNumberController extends GetxController {
  static const String phoneNumberDocName = 'phoneNumberDoc';

  late DocumentReference phoneNumberReference;
  final db = FirebaseFirestore.instance;
  var isChecked = false.obs;
  var isUpdated = false.obs;
  var number1 = ''.obs;
  var number2 = ''.obs;
  var number3 = ''.obs;


  @override
  void onInit() {
    super.onInit();

    phoneNumberReference = db.collection('aboutUs').doc(phoneNumberDocName);
  }

  Future<void> setPhoneNumber() async {
    await phoneNumberReference.set(PhoneNumberModel('','','').setData());
  }

  // 전화번호 가져오기
  Future<void> getPhoneNumber() async {
    await phoneNumberReference.get().then(
      (DocumentSnapshot doc) {
        if( doc.data() != null) {
          final snapshotData = PhoneNumberModel.getSnapshotData(doc);
          number1.value = snapshotData.number1;
          number2.value = snapshotData.number2;
          number3.value = snapshotData.number3;
        }
      },

      onError: (e) => print("Error completing: $e"),
    );

    if( number1.value != '' ) {
      isChecked.value = true;
    }
  }


  // 전화번호 저장
  Future<bool> updatePhoneNumber(String newNumber1, String newNumber2, String newNumber3) async {
    try {
      await phoneNumberReference.update({
        'number1' : newNumber1,
        'number2' : newNumber2,
        'number3' : newNumber3,
      });
      return true;

    } catch(e) {
      print(e);
      return false;
    }
  }
}