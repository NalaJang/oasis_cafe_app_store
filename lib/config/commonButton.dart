import 'package:flutter/material.dart';

class CommonButton {

  // 수정하기 버튼
  Widget editButton(BuildContext context, String routeName) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, routeName);
      },
      child: const Text(
        '수정하기',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 17.0
        ),
      ),
    );
  }
}