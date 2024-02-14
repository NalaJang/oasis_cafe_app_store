import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';

import '../strings/strings_en.dart';

class CommonButton {


  // 확인(제출) 버튼
  static Widget submitButton(String content) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.backgroundColor1,
          side: const BorderSide(
            color: Palette.buttonColor1
          )
        ),

        onPressed: (){
          Get.snackbar(
            content,
            '$content 처리되었습니다.',
            snackPosition: SnackPosition.TOP,
          );

          // 취소 처리 snackbar 가 띄워지고 1초 후 다이얼로그 닫기
          Future.delayed(const Duration(seconds: 1), () {
            Get.key.currentState?.pop(true);
          });

          // if( content == '완료' || content == '픽업' || content == '주문 취소' ) {
          //   processingConfirm = true;
          // }
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text(
          //         '$content 처리되었습니다.',
          //       ),
          //     )
          // );
        },
        child: const Text(Strings.submit)
    );
  }

  // 취소 버튼
  static Widget cancelButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(
          color: Palette.buttonColor1
        )
      ),

      onPressed: () => Get.key.currentState?.pop(false),

      child: const Text(
          Strings.cancel,
          style: TextStyle(
            color: Palette.textColor1
        ),
      )
    );
  }

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