import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OpeningHoursModel {

  final db = FirebaseFirestore.instance;

  List<String> openAmPm = [];
  List<String> closeAmPm = [];
  List<TextEditingController> openHours = [];
  List<TextEditingController> openMinutes = [];
  List<TextEditingController> closeHours = [];
  List<TextEditingController> closeMinutes = [];

  String monday = '';
  String tuesday = '';
  String wednesday = '';
  String thursday = '';
  String friday = '';
  String saturday = '';
  String sunday = '';

  var mondayOpenAmPm = '';
  var mondayCloseAmPm = '';
  var mondayOpenHour = TextEditingController();
  var mondayOpenMinutes = TextEditingController();
  var mondayCloseHour = TextEditingController();
  var mondayCloseMinutes = TextEditingController();

  var tuesdayOpenAmPm = '';
  var tuesdayCloseAmPm = '';
  var tuesdayOpenHour = TextEditingController();
  var tuesdayOpenMinutes = TextEditingController();
  var tuesdayCloseHour = TextEditingController();
  var tuesdayCloseMinutes = TextEditingController();

  var wednesdayOpenAmPm = '';
  var wednesdayCloseAmPm = '';
  var wednesdayOpenHour = TextEditingController();
  var wednesdayOpenMinutes = TextEditingController();
  var wednesdayCloseHour = TextEditingController();
  var wednesdayCloseMinutes = TextEditingController();

  var thursdayOpenAmPm = '';
  var thursdayCloseAmPm = '';
  var thursdayOpenHour = TextEditingController();
  var thursdayOpenMinutes = TextEditingController();
  var thursdayCloseHour = TextEditingController();
  var thursdayCloseMinutes = TextEditingController();

  var fridayOpenAmPm = '';
  var fridayCloseAmPm = '';
  var fridayOpenHour = TextEditingController();
  var fridayOpenMinutes = TextEditingController();
  var fridayCloseHour = TextEditingController();
  var fridayCloseMinutes = TextEditingController();

  var saturdayOpenAmPm = '';
  var saturdayCloseAmPm = '';
  var saturdayOpenHour = TextEditingController();
  var saturdayOpenMinutes = TextEditingController();
  var saturdayCloseHour = TextEditingController();
  var saturdayCloseMinutes = TextEditingController();

  var sundayOpenAmPm = '';
  var sundayCloseAmPm = '';
  var sundayOpenHour = TextEditingController();
  var sundayOpenMinutes = TextEditingController();
  var sundayCloseHour = TextEditingController();
  var sundayCloseMinutes = TextEditingController();


  OpeningHoursModel() {

    getOpeningHours();

    openAmPm = [mondayOpenAmPm, tuesdayOpenAmPm, wednesdayOpenAmPm,
    thursdayOpenAmPm, fridayOpenAmPm, saturdayOpenAmPm, sundayOpenAmPm];
    closeAmPm = [mondayCloseAmPm, tuesdayCloseAmPm, wednesdayCloseAmPm,
    thursdayCloseAmPm, fridayCloseAmPm, saturdayCloseAmPm, sundayCloseAmPm];

    openHours = [mondayOpenHour, tuesdayOpenHour, wednesdayOpenHour,
      thursdayOpenHour, fridayOpenHour, saturdayOpenHour, sundayOpenHour];

    openMinutes = [mondayOpenMinutes, tuesdayOpenMinutes, wednesdayOpenMinutes,
      thursdayOpenMinutes, fridayOpenMinutes, saturdayOpenMinutes, sundayOpenMinutes];

    closeHours = [mondayCloseHour, tuesdayCloseHour, wednesdayCloseHour,
      thursdayCloseHour, fridayCloseHour, saturdayCloseHour, sundayCloseHour];

    closeMinutes = [mondayCloseMinutes, tuesdayCloseMinutes, wednesdayCloseMinutes,
      thursdayCloseMinutes, fridayCloseMinutes, saturdayCloseMinutes, sundayCloseMinutes];
  }


  // 영업 시간 가져오기
  Future<void> getOpeningHours() async {
    await db.collection('aboutUs')
        .doc('DGiejo4a7ZkeWpC8OnY6')
        .get()
        .then((value) {

          monday = value['monday'];
          tuesday = value['tuesday'];
          wednesday = value['wednesday'];
          thursday = value['thursday'];
          friday = value['friday'];
          saturday = value['saturday'];
          sunday = value['sunday'];


          // splitData();
          // 데이터 예시 > 오전 8:00 ~ 오후 3:00// 데이터 예시 > 오전 8:00 ~ 오후 3:00
          var splitMonday = monday.toString().split(' ');
          var splitMondayOpenTime = splitMonday[1].split(':');
          var splitMondayCloseTime = splitMonday[4].split(':');
          mondayOpenAmPm = splitMonday[0];
          mondayCloseAmPm = splitMonday[0];
          mondayOpenHour.text = splitMondayOpenTime[0];
          mondayOpenMinutes.text = splitMondayOpenTime[1];
          mondayCloseHour.text = splitMondayCloseTime[0];
          mondayCloseMinutes.text = splitMondayCloseTime[1];

          var splitTuesday = tuesday.toString().split(' ');
          var splitTuesdayOpenTime = splitTuesday[1].split(':');
          var splitTuesdayCloseTime = splitTuesday[4].split(':');
          tuesdayOpenAmPm = splitTuesday[0];
          tuesdayCloseAmPm = splitTuesday[0];
          tuesdayOpenHour.text = splitTuesdayOpenTime[0];
          tuesdayOpenMinutes.text = splitTuesdayOpenTime[1];
          tuesdayCloseHour.text = splitTuesdayCloseTime[0];
          tuesdayCloseMinutes.text = splitTuesdayCloseTime[1];

    });
  }

  Future<void> splitData() async {
    // 데이터 예시 > 오전 8:00 ~ 오후 3:00
    var splitMonday = monday.toString().split(' ');
    var splitMondayOpenTime = splitMonday[1].split(':');
    var splitMondayCloseTime = splitMonday[4].split(':');
    mondayOpenAmPm = splitMonday[0];
    mondayCloseAmPm = splitMonday[0];
    mondayOpenHour.text = splitMondayOpenTime[0];
    mondayOpenMinutes.text = splitMondayOpenTime[1];
    mondayCloseHour.text = splitMondayCloseTime[0];
    mondayCloseMinutes.text = splitMondayCloseTime[1];

    var splitTuesday = tuesday.toString().split(' ');
    var splitTuesdayOpenTime = splitTuesday[1].split(':');
    var splitTuesdayCloseTime = splitTuesday[4].split(':');
    tuesdayOpenAmPm = splitTuesday[0];
    tuesdayCloseAmPm = splitTuesday[0];
    tuesdayOpenHour.text = splitTuesdayOpenTime[0];
    tuesdayOpenMinutes.text = splitTuesdayOpenTime[1];
    tuesdayCloseHour.text = splitTuesdayCloseTime[0];
    tuesdayCloseMinutes.text = splitTuesdayCloseTime[1];
  }

}