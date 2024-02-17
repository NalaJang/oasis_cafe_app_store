import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';
import 'package:oasis_cafe_app_store/model/model_openingHours.dart';
import 'package:oasis_cafe_app_store/provider/openingHoursController.dart';
import 'package:provider/provider.dart';

import '../../../config/circularProgressIndicator.dart';

class OpeningHoursEditPage extends StatelessWidget {
  const OpeningHoursEditPage({Key? key}) : super(key: key);

  static const String routeName = '/openingHoursEditPage';

  @override
  Widget build(BuildContext context) {

    var openingHoursProvider = Get.find<OpeningHoursController>();
    openingHoursProvider.getOpeningHours();
    List<String> dayList = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor1,
        title: const Text('운영시간 수정'),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 10.0, top: 10.0),
        child:
        openingHoursProvider.openingHoursList.isEmpty ?
          CircularProgressBar.circularProgressBar :

          Obx(() {
            return Column(
              children: [
                for( var day = 0; day < dayList.length; day++ )
                  SetOpeningHoursTime(
                    date: openingHoursProvider.openingHoursList[day].id,
                    day: dayList[day],
                    openTime: openingHoursProvider.openingHoursList[day].openTime,
                    closeTime: openingHoursProvider.openingHoursList[day].closeTime
                  ),
              ],
            );
          }),
      )
    );
  }
}

class SetOpeningHoursTime extends StatefulWidget {
  const SetOpeningHoursTime({required this.date, required this.day,
    required this.openTime, required this.closeTime, Key? key}) : super(key: key);

  final String date;
  final String day;
  final DateTime openTime;
  final DateTime closeTime;


  @override
  State<SetOpeningHoursTime> createState() => _SetOpeningHoursTime();
}

class _SetOpeningHoursTime extends State<SetOpeningHoursTime> {

  String changedOpenHour = '';
  String changedOpenMinutes = '';
  String changedCloseHour = '';
  String changedCloseMinutes = '';

  @override
  void initState() {
    super.initState();

    changedOpenHour = widget.openTime.hour.toString();
    changedOpenMinutes = widget.openTime.minute.toString();
    changedCloseHour = widget.closeTime.hour.toString();
    changedCloseMinutes = widget.closeTime.minute.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.day,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 17.0,
            fontWeight: FontWeight.bold
          ),
        ),

        Row(
          children: [
            const Text('시작'),
            // 시작 시간
            CupertinoButton(
              onPressed: () => _showTimePickerDialog(
                widget.date,
                CupertinoDatePicker(
                  initialDateTime: widget.openTime,
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: false,
                  minuteInterval: 30,
                  onDateTimeChanged: (DateTime newTime) {
                    changedOpenHour = newTime.hour.toString();
                    changedOpenMinutes = newTime.minute.toString();
                  },
                ),
              ),

              // 설정된 시간 보여주기
              child: setTimeText(widget.openTime),
            ),
          ],
        ),

        Row(
          children: [
            const Text('종료'),
            // 종료 시간
            CupertinoButton(
              onPressed: () => _showTimePickerDialog(
                widget.date,
                CupertinoDatePicker(
                  initialDateTime: widget.closeTime,
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: false,
                  minuteInterval: 30,
                  onDateTimeChanged: (DateTime newTime) {
                    changedCloseHour = newTime.hour.toString();
                    changedCloseMinutes = newTime.minute.toString();
                  },
                ),
              ),

              // 설정된 시간 보여주기
              child: setTimeText(widget.closeTime),
            ),
          ],
        ),
      ],
    );
  }


  // 설정된 시간 보여주기
  Container setTimeText(DateTime time) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8.0)
      ),

      child: Text(
        time.minute.isEqual(0) ?
        '${time.hour} : 00' : '${time.hour} : ${time.minute}',

        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.black87
        ),
      ),
    );
  }


  void _showTimePickerDialog(String selectedDate, Widget child) {
    double popupHeight = MediaQuery.of(context).size.height * 0.4;
    var provider = Get.find<OpeningHoursController>();

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: popupHeight,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 취소
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text('취소'),
                ),


                // 휴무
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                    provider.updateTime(selectedDate, '00', '00', '00', '00');
                  },
                  child: const Text(
                    '휴무',
                    style: TextStyle(
                      color: Colors.red
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: child),

            Container(
              padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  side: const BorderSide(
                      color: Colors.white
                  )
                ),
                onPressed: (){
                  Navigator.pop(context);
                  provider.updateTime(selectedDate, changedOpenHour, changedOpenMinutes,
                      changedCloseHour, changedCloseMinutes);
                },
                child: const Text('적용'),
              ),
            ),
          ],
        )
      ),
    );
  }
}
