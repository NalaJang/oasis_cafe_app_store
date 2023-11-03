import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';
import 'package:oasis_cafe_app_store/model/model_openingHours.dart';
import 'package:oasis_cafe_app_store/provider/openingHoursProvider.dart';
import 'package:provider/provider.dart';

class AboutUsEditPage extends StatefulWidget {
  const AboutUsEditPage({Key? key}) : super(key: key);

  @override
  State<AboutUsEditPage> createState() => _AboutUsEditPageState();
}

class _AboutUsEditPageState extends State<AboutUsEditPage> {


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
        padding: const EdgeInsets.all(10.0),
        child:
        openingHoursProvider.hoursList.isEmpty ?
          const CircularProgressIndicator() :

          Column(
            children: [
              for( var day = 0; day < dayList.length; day++ )
                SetOpeningHoursTime(
                  id: openingHoursProvider.hoursList[day].id,
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
  const SetOpeningHoursTime({required this.id, required this.day,
    required this.openTime, required this.closeTime, Key? key}) : super(key: key);

  final String id;
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
        Text(widget.day),
        const Text('시작'),
        CupertinoButton(
          onPressed: () => _showTimePickerDialog(
            widget.id,
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

          child: setTimeText(widget.openTime),
        ),

        const Text('종료'),
        CupertinoButton(
          onPressed: () => _showTimePickerDialog(
            widget.id,
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

          child: setTimeText(widget.closeTime),
        ),
      ],
    );
  }


  Container setTimeText(DateTime time) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(8.0)
      ),

      child: Text(
        time.minute.toString() == '0' ?
        '${time.hour} : 00' : '${time.hour} : ${time.minute}',

        style: const TextStyle(
            fontSize: 18.0,
            color: Colors.black87
        ),
      ),
    );
  }


  void _showTimePickerDialog(String id, Widget child) {
    var provider = Provider.of<OpeningHoursProvider>(context, listen: false);

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                provider.updateTime(id, changedOpenHour, changedOpenMinutes,
                    changedCloseHour, changedCloseMinutes);
              },
              child: const Text('Done'),
            ),
            Expanded(child: child)
          ],
        )
      ),
    );
  }
}
