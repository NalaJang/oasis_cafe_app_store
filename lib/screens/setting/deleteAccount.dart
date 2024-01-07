import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/config/commonDialog.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: GestureDetector(
        onTap: (){
          CommonDialog().showConfirmDialog(context, '계정을 삭제하시겠습니까?');
        },
        child: const Text(
          '계정 삭제',
          style: TextStyle(
            color: Colors.red,
            decoration: TextDecoration.underline
          ),
        ),
      ),
    );
  }
}
