import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:oasis_cafe_app_store/strings/strings_en.dart';

import '../model/model_openingHours.dart';

class OpeningHoursController extends GetxController {

  final db = FirebaseFirestore.instance;
  late CollectionReference openingHoursDocument;
  late CollectionReference openingHoursCollection;
  // List<OpeningHoursModel> hoursList = [];
  var openingHoursList = <OpeningHoursModel>[].obs;

  OpeningHoursController() {
    openingHoursDocument = db.collection(Strings.collection_aboutUs)
                            .doc(Strings.document_openingHours)
                            .collection(Strings.collection_openingHours);
  }


  // 기본 데이터 세팅
  Future<void> setOpeningHours() async {
    for( int i = 0; i < 7; i++ ) {
      await openingHoursDocument
          .doc(i.toString())
          .set(
          OpeningHoursModel('오전', '8', '00', '오후', '3', '00').setData()
      );
    }
  }


  Future<void> getOpeningHours() async {
    List<OpeningHoursModel> tempList = await openingHoursDocument.get().then((querySnapshot) {
      return querySnapshot.docs.map((document) {
        return OpeningHoursModel.getSnapshotData(document);
      }).toList();
    });

    // Use RxList constructor to convert the list to RxList
    openingHoursList.assignAll(tempList.obs);
  }


  // 운영 시간 업데이트
  Future<void> updateTime(String date, String openHour, String openMinutes,
      String closeHour, String closeMinutes) async {

    await openingHoursDocument.doc(date).update({
      'openHour' : openHour,
      'openMinutes' : openMinutes,
      'closeHour' : closeHour,
      'closeMinutes' : closeMinutes,
    });
  }
}