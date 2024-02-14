import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';
import 'package:oasis_cafe_app_store/screens/aboutUs/openingHours.dart';
import 'package:oasis_cafe_app_store/screens/aboutUs/phoneNumber.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About us'),
        backgroundColor: Palette.backgroundColor1,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [

              // 영업 시간
              OpeningHours(),

              Divider(height: 30, color: Colors.grey,),

              // 매장 전화번호
              PhoneNumber(),

              // 매장 위치
              // Location()
            ],
          ),
        ),
      ),
    );
  }
}
