import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oasis_cafe_app_store/config/commonButton.dart';
import 'package:oasis_cafe_app_store/config/gaps.dart';

class CommonDialog {


  showConfirmDialog(String content) {
    return Get.dialog(
      // 다이얼로그 바깥 영역 터치 방지
      barrierDismissible: false,

      AlertDialog(
        content: Text(content),

        actions: [
          // 취소 버튼
          CommonButton.roundBorderCancelButton(),

          Gaps.gapW10,

          // 확인 버튼
          CommonButton.roundBorderConfirmButton()
        ],
      )
    );
  }
}