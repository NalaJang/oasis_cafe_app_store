import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oasis cafe'),
        backgroundColor: Palette.buttonColor1,
      ),
    );
  }
}
