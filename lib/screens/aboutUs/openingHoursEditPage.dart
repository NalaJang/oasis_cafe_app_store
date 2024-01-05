import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';
import 'package:oasis_cafe_app_store/model/model_openingHours.dart';
import 'package:oasis_cafe_app_store/provider/openingHoursProvider.dart';
import 'package:provider/provider.dart';

class OpeningHoursEditPage extends StatefulWidget {
  const OpeningHoursEditPage({Key? key}) : super(key: key);

  static const String routeName = '/openingHoursEditPage';

  @override
  State<OpeningHoursEditPage> createState() => _OpeningHoursEditPageState();
}

class _OpeningHoursEditPageState extends State<OpeningHoursEditPage> {


  @override
  Widget build(BuildContext context) {

    var openingHoursProvider = Provider.of<OpeningHoursProvider>(context);
    openingHoursProvider.getOpeningHours();
    List<String> dayList = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor1,
        title: const Text('운영시간 수정'),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
        child:
        openingHoursProvider.hoursList.isEmpty ?
          const CircularProgressIndicator() :

          Column(
            children: [
              for( var day = 0; day < dayList.length; day++ )
                SetOpeningHoursTime(
                    date: openingHoursProvider.hoursList[day].id,
                  day: dayList[day],
                  openTime: openingHoursProvider.hoursList[day].openTime,
                  closeTime: openingHoursProvider.hoursList[day].closeTime
                ),
            ],
          ),
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
      children: [
        Expanded(
          child: Text(
            widget.day,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 17.0,
              fontWeight: FontWeight.bold
            ),
          ),
        ),

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

        const SizedBox(width: 15.0,),
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
    var provider = Provider.of<OpeningHoursProvider>(context, listen: false);

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
                    provider.updateTime(selectedDate, '0', '0', '0', '0');
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
