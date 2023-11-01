import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';
import 'package:oasis_cafe_app_store/model/model_openingHours.dart';

class AboutUsEditPage extends StatefulWidget {
  const AboutUsEditPage({Key? key}) : super(key: key);

  @override
  State<AboutUsEditPage> createState() => _AboutUsEditPageState();
}

class _AboutUsEditPageState extends State<AboutUsEditPage> {

  var openingHoursModel = OpeningHoursModel();
  List<String> dayList = ['월', '화', '수', '목', '금', '토', '일'];

  DateTime _openTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
      DateTime.now().hour, 00);
  DateTime _closeTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
      DateTime.now().hour, 0);


  Container setSelectedTime(DateTime time) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(8.0)
      ),
      child: Text(
        '${time.hour} : ${time.minute}',
        style: const TextStyle(
            fontSize: 18.0,
            color: Colors.black87
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor1,
        title: const Text('운영시간 수정'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Text('평일(월~금)'),
                  const Text('시작'),
                  CupertinoButton(
                    onPressed: () => _showTimePickerDialog(
                      CupertinoDatePicker(
                        initialDateTime: _openTime,
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: false,
                        minuteInterval: 30,
                        onDateTimeChanged: (DateTime newTime) {
                          setState(() => _openTime = newTime);
                        },
                      ),
                    ),

                    child: setSelectedTime(_openTime),
                  ),

                  const Text('종료'),
                  CupertinoButton(
                    onPressed: () => _showTimePickerDialog(
                      CupertinoDatePicker(
                        initialDateTime: _closeTime,
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: true,
                        minuteInterval: 30,
                        onDateTimeChanged: (DateTime newTime) {
                          setState(() => _closeTime = newTime);
                        },
                      ),
                    ),

                    child: setSelectedTime(_closeTime)
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _showTimePickerDialog(Widget child) {
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
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}
