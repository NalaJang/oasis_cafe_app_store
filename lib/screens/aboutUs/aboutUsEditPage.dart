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

  var chagedTime;

  @override
  Widget build(BuildContext context) {
    var openingHoursProvider = Provider.of<OpeningHoursProvider>(context);
    openingHoursProvider.getOpeningHours();

    late DateTime openTime;
    DateTime closeTime;
    String id = '';

    for( var i = 0; i < openingHoursProvider.hoursList.length; i++ ) {
      id = openingHoursProvider.hoursList[i].id;
      openTime = openingHoursProvider.hoursList[i].openTime;
      closeTime = openingHoursProvider.hoursList[i].closeTime;
    }


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
                  const Text('월요일'),
                  const Text('시작'),
                  CupertinoButton(
                    onPressed: () => _showTimePickerDialog(
                      id,
                      CupertinoDatePicker(
                        initialDateTime: openTime,
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: false,
                        minuteInterval: 30,
                        onDateTimeChanged: (DateTime newTime) {
                          chagedTime = newTime.hour.toString();
                        },
                      ),
                    ),

                    child: setSelectedTime(openTime),
                  ),

                  const Text('종료'),
                  // CupertinoButton(
                  //     onPressed: () => _showTimePickerDialog(
                  //         _timePicker()
                  //     ),
                  //
                  //     child: setSelectedTime(_closeTime)
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


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
          children: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                provider.updateTime(id, chagedTime);
              },
              child: const Text('Done'),
            ),
            Expanded(child: child)
          ],
        )
      ),
    );
  }

  // CupertinoDatePicker _timePicker() {
  //   return CupertinoDatePicker(
  //     initialDateTime: _closeTime,
  //     mode: CupertinoDatePickerMode.time,
  //     use24hFormat: true,
  //     minuteInterval: 30,
  //     onDateTimeChanged: (DateTime newTime) {
  //       setState(() => _closeTime = newTime);
  //     },
  //   );
  // }
}
