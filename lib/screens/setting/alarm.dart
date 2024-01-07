import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/provider/userStateProvider.dart';
import 'package:provider/provider.dart';

class Alarm extends StatefulWidget {
  const Alarm({Key? key}) : super(key: key);

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {

  @override
  Widget build(BuildContext context) {


    var usrStateProvider = Provider.of<UserStateProvider>(context);
    String userUid = usrStateProvider.userUid;
    bool isSelected = usrStateProvider.notification;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '주문 알람 설정',
          style: TextStyle(
            fontSize: 18.0
          ),
        ),

        Switch(
          value: isSelected,
          onChanged: (value) {
            setState(() {
              isSelected = value;
              usrStateProvider.notification = isSelected;
              UserStateProvider().updateAlarmSetting(userUid, isSelected);
            });
          }
        )
      ],
    );
  }
}