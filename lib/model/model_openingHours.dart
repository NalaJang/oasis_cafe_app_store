import 'package:flutter/cupertino.dart';

class OpeningHoursModel {

  List<String> dayList = ['월', '화', '수', '목', '금', '토', '일'];
  List<TextEditingController> openHours = [];
  List<TextEditingController> openMinutes = [];
  List<TextEditingController> closeHours = [];
  List<TextEditingController> closeMinutes = [];

  var mondayOpenHour = TextEditingController();
  var mondayOpenMinutes = TextEditingController();
  var mondayCloseHour = TextEditingController();
  var mondayCloseMinutes = TextEditingController();

  var tuesdayOpenHour = TextEditingController();
  var tuesdayOpenMinutes = TextEditingController();
  var tuesdayCloseHour = TextEditingController();
  var tuesdayCloseMinutes = TextEditingController();

  var wednesdayOpenHour = TextEditingController();
  var wednesdayOpenMinutes = TextEditingController();
  var wednesdayCloseHour = TextEditingController();
  var wednesdayCloseMinutes = TextEditingController();

  var thursdayOpenHour = TextEditingController();
  var thursdayOpenMinutes = TextEditingController();
  var thursdayCloseHour = TextEditingController();
  var thursdayCloseMinutes = TextEditingController();

  var fridayOpenHour = TextEditingController();
  var fridayOpenMinutes = TextEditingController();
  var fridayCloseHour = TextEditingController();
  var fridayCloseMinutes = TextEditingController();

  var saturdayOpenHour = TextEditingController();
  var saturdayOpenMinutes = TextEditingController();
  var saturdayCloseHour = TextEditingController();
  var saturdayCloseMinutes = TextEditingController();

  var sundayOpenHour = TextEditingController();
  var sundayOpenMinutes = TextEditingController();
  var sundayCloseHour = TextEditingController();
  var sundayCloseMinutes = TextEditingController();

  OpeningHoursModel() {
    openHours = [mondayOpenHour, tuesdayOpenHour, wednesdayOpenHour,
      thursdayOpenHour, fridayOpenHour, saturdayOpenHour, sundayOpenHour];

    openMinutes = [mondayOpenMinutes, tuesdayOpenMinutes, wednesdayOpenMinutes,
      thursdayOpenMinutes, fridayOpenMinutes, saturdayOpenMinutes, sundayOpenMinutes];

    closeHours = [mondayCloseHour, tuesdayCloseHour, wednesdayCloseHour,
      thursdayCloseHour, fridayCloseHour, saturdayCloseHour, sundayCloseHour];

    closeMinutes = [mondayCloseMinutes, tuesdayCloseMinutes, wednesdayCloseMinutes,
      thursdayCloseMinutes, fridayCloseMinutes, saturdayCloseMinutes, sundayCloseMinutes];
  }

}