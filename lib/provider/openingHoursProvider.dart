import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/model_openingHours.dart';

class OpeningHoursProvider with ChangeNotifier {
  final db = FirebaseFirestore.instance;
  late DocumentReference openingHoursDocument;
  late CollectionReference openingHoursCollection;
  List<OpeningHoursModel> hoursList = [];


  OpeningHoursProvider() {
    openingHoursDocument = db.collection('aboutUs').doc('DGiejo4a7ZkeWpC8OnY6');
    // openingHoursCollection = db.collection('aboutUs');
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