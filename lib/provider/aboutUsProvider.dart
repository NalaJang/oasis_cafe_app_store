import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AboutUsProvider with ChangeNotifier {

  final db = FirebaseFirestore.instance;
  late CollectionReference aboutUsCollection;

  String monday = '';
  String tuesday = '';
  String wednesday = '';
  String thursday = '';
  String friday = '';
  String saturday = '';
  String sunday = '';

  List<String> dayList = [];

  AboutUsProvider() {
    aboutUsCollection = db.collection('aboutUs');
  }


  // 가게 정보 가져오기
  Future<void> getStoreInfo() async {
    await aboutUsCollection.doc('DGiejo4a7ZkeWpC8OnY6').get().then((value) {
      monday = value['monday'];
      tuesday = value['tuesday'];
      wednesday = value['wednesday'];
      thursday = value['thursday'];
      friday = value['friday'];
      saturday = value['saturday'];
      sunday = value['sunday'];

      dayList.add(monday);
      dayList.add(tuesday);
      dayList.add(wednesday);
      dayList.add(thursday);
      dayList.add(friday);
      dayList.add(saturday);
      dayList.add(sunday);
    });

    notifyListeners();

  }
}