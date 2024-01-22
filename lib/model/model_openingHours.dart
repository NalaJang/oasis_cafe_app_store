import 'package:cloud_firestore/cloud_firestore.dart';

class OpeningHoursModel {

  String id = '';
  String openAmPm = '';
  String openHour = '';
  String openMinutes = '';
  String closeAmPm = '';
  String closeHour = '';
  String closeMinutes = '';

  DateTime openTime =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
      DateTime.now().hour, DateTime.now().minute);
  DateTime closeTime =  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
      DateTime.now().hour, DateTime.now().minute);

  OpeningHoursModel(
      this.openAmPm, this.openHour, this.openMinutes,
      this.closeAmPm, this.closeHour, this.closeMinutes
      );


  Map<String, dynamic> setData() {
    return {
      "openAmPm": openAmPm,
      "openHour": openHour,
      "openMinutes": openMinutes,
      "closeAmPm": closeAmPm,
      "closeHour": closeHour,
      "closeMinutes": closeMinutes,
    };
  }


  OpeningHoursModel.getSnapshotData(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    id = snapshot.id;
    openAmPm = data['openAmPm'];
    openHour = data['openHour'];
    openMinutes = data['openMinutes'];
    closeAmPm = data['closeAmPm'];
    closeHour = data['closeHour'];
    closeMinutes = data['closeMinutes'];


    if( openMinutes == '0' ) {
      openMinutes = openMinutes.padRight(2, '0');
    }
    if( closeMinutes == '0' ) {
      closeMinutes = closeMinutes.padRight(2, '0');
    }

    openTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
        int.parse(openHour), int.parse(openMinutes));
    closeTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
        int.parse(closeHour), int.parse(closeMinutes));


    if( int.parse(openHour) > 12 ) {
      openHour = (int.parse(openHour) - 12).toString();
    } else if( int.parse(closeHour) > 12 ) {
      closeHour = (int.parse(closeHour) - 12).toString();
    }

  }

}