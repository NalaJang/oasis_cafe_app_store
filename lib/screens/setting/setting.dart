import 'package:flutter/material.dart';

import '../../config/palette.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        backgroundColor: Palette.backgroundColor1,
      ),
    );
  }
}
