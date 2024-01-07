import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/model_openingHours.dart';

class OpeningHoursProvider with ChangeNotifier {
  static const String openingHoursDocName = 'openingHoursDoc';

  final db = FirebaseFirestore.instance;
  late DocumentReference openingHoursDocument;
  late CollectionReference openingHoursCollection;
  List<OpeningHoursModel> hoursList = [];

  OpeningHoursProvider() {
    openingHoursDocument = db.collection('aboutUs').doc(openingHoursDocName);
  }


  // 기본 데이터 세팅
  Future<void> setOpeningHours() async {
    print('setOpeningHours');
    for( int i = 0; i < 7; i++ ) {
      await openingHoursDocument.collection('openingHours')
          .doc(i.toString())
          .set(
          OpeningHoursModel('오전', '8', '0', '오후', '3', '0').setData()
      );
    }
  }


  Future<void> getOpeningHours() async {
    hoursList = await openingHoursDocument.collection('openingHours').get().then((querySnapshot) {
      return querySnapshot.docs.map((document) {
        return OpeningHoursModel.getSnapshotData(document);
      }).toList();
    });
    notifyListeners();
  }


  // 운영 시간 업데이트
  Future<void> updateTime(String date, String openHour, String openMinutes,
      String closeHour, String closeMinutes) async {

    await openingHoursDocument.collection('openingHours').doc(date).update({
      'openHour' : openHour,
      'openMinutes' : openMinutes,
      'closeHour' : closeHour,
      'closeMinutes' : closeMinutes,
    });
  }
}