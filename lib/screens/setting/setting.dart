import 'package:flutter/material.dart';

import '../../config/palette.dart';
import 'alarm.dart';

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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Alarm(),
          ],
        ),
      ),
    );
  }
}
