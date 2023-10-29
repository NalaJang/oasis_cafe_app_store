import 'package:flutter/material.dart';

class AboutUsEditPage extends StatefulWidget {
  const AboutUsEditPage({Key? key}) : super(key: key);

  @override
  State<AboutUsEditPage> createState() => _AboutUsEditPageState();
}

class _AboutUsEditPageState extends State<AboutUsEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('운영시간 수정'),
      ),
    );
  }
}
