import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oasis_cafe_app_store/config/commonDialog.dart';
import 'package:oasis_cafe_app_store/screens/login/login.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../provider/userStateProvider.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: GestureDetector(
        onTap: () async {
          var result = await CommonDialog().showConfirmDialog('계정을 삭제하시겠습니까?');
          if(  result ) {

            var isDeleted = await Provider.of<UserStateProvider>((context), listen: false).deleteAccount();

            if( isDeleted ) {
              // 이전의 모든 페이지 제거
              Get.offAll(() => const Login());
            }
          }
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
