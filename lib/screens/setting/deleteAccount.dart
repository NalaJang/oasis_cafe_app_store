import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/config/commonDialog.dart';
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
          var result = CommonDialog().showConfirmDialog(context, '계정을 삭제하시겠습니까?');
          if( await result ) {

            var isDeleted = Provider.of<UserStateProvider>((context), listen: false).deleteAccount();

            if( await isDeleted ) {



              Navigator.pushAndRemoveUntil(
                (context),
                MaterialPageRoute(
                  builder: (context) => const MyApp()
                ), (route) => false
              );
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
