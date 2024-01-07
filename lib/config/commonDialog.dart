import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/config/gaps.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';
import 'package:oasis_cafe_app_store/main.dart';

class CommonDialog {

  showConfirmDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(content),

          actions: [
            // 취소 버튼
            _cancelButton(context),

            Gaps.gapW10,

            // 확인 버튼
            _confirmButton(context)
          ],
        );
      }
    );

  }


  // 취소 버튼
  Widget _cancelButton(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        side: const BorderSide(
          color: Palette.buttonColor1,
        )
      ),
      child: const Text(
        '아니오',
        style: TextStyle(
          color: Palette.buttonColor1
        ),
      ),
    );
  }

  // 확인 버튼
  Widget _confirmButton(BuildContext context) {
    return ElevatedButton(
      onPressed: (){

        // Navigator.pushAndRemoveUntil(
        //   (context),
        //   MaterialPageRoute(
        //     builder: (context) => const MyApp()
        //   ), (route) => false
        // );

      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Palette.buttonColor1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        side: const BorderSide(
          color: Palette.buttonColor1,
        )
      ),
      child: const Text('예'),
    );
  }
}