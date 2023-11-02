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


  OpeningHoursModel.getSnapshotData(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    id = snapshot.id;
    openAmPm = data['openAmPm'];
    openHour = data['openHour'];
    openMinutes = data['openMinutes'];
    closeAmPm = data['closeAmPm'];
    closeHour = data['closeHour'];
    closeMinutes = data['closeMinutes'];

    openTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
        int.parse(openHour), int.parse(openMinutes));
    closeTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
        int.parse(closeHour), int.parse(closeMinutes));

  }

}