import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneNumberModel {

  String id = '';
  String number1 = '';
  String number2 = '';
  String number3 = '';

  PhoneNumberModel(this.number1, this.number2, this.number3);

  Map<String, dynamic> setData() {
    return {
      'number1' : number1,
      'number2' : number2,
      'number3' : number3,
    };
  }

  PhoneNumberModel.getSnapshotData(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    id = snapshot.id;
    number1 = data['number1'];
    number2 = data['number2'];
    number3 = data['number3'];
  }
}