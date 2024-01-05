import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/screens/aboutUs/editPages/phoneNumberEditPage.dart';

import '../../config/commonButton.dart';

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _title(),

            // 수정하기 버튼
            CommonButton().editButton(context, PhoneNumberEditPage.routeName),
          ],
        ),

        const Text(
          '02-743-1234',
          style: TextStyle(
            fontSize: 17.0
          ),
        )
      ],
    );
  }

  Widget _title() {
    return Row(
      children: const [
        Icon(Icons.phone),

        Text(
          ' 전화번호',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}
