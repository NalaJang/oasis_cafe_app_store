import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oasis_cafe_app_store/config/gaps.dart';
import 'package:oasis_cafe_app_store/provider/phoneNumberController.dart';
import 'package:oasis_cafe_app_store/screens/aboutUs/editPages/phoneNumberEditPage.dart';

import '../../config/commonButton.dart';

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var phoneNumberController = Get.find<PhoneNumberController>();
    // 전화번호 가져오기
    phoneNumberController.getPhoneNumber();

    return Obx(
      () {
        String phoneNumber = '';

        if( phoneNumberController.isChecked.value ) {
          phoneNumber = '${phoneNumberController.number1} - ${phoneNumberController.number2} - ${phoneNumberController.number3}';
        } else {
          phoneNumber = '등록된 번호가 없습니다.';
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _title(),

                // 수정하기 버튼
                CommonButton().editButton(context, PhoneNumberEditPage.routeName),
              ],
            ),

            Gaps.gapH10,

            Text(
              phoneNumber,
              style: const TextStyle(
                  fontSize: 17.0
              ),
            )
          ],
        );
      }
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
