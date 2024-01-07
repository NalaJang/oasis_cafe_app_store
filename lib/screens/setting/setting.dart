import 'package:flutter/material.dart';

import '../../config/gaps.dart';
import '../../config/palette.dart';
import 'alarm.dart';
import 'deleteAccount.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        backgroundColor: Palette.backgroundColor1,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(

          children: [
            // 알람
            const Alarm(),
            Gaps.gapH10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('앱 버전', style: TextStyle(fontSize: 18.0),),
                Text('v1.0.0', style: TextStyle(fontSize: 18.0),),
              ],
            ),

            Gaps.spacer,

            // 계정 삭제
            const DeleteAccount()
          ],
        ),
      ),
    );
  }
}
