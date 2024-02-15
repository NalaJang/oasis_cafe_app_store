import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oasis_cafe_app_store/config/commonDialog.dart';
import 'package:oasis_cafe_app_store/screens/login/login.dart';
import 'package:provider/provider.dart';

import '../../config/palette.dart';
import '../../provider/userStateProvider.dart';
import '../../strings/strings_en.dart';
import '../aboutUs/aboutUs.dart';
import '../setting/setting.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                _drawerHeader(context),

                // 새 메뉴 추가, 메뉴 정보 수정, 메뉴 품절 등
                ListTile(
                  leading: const Icon(Icons.event_note_outlined),
                  title: const Text('메뉴 관리'),
                  onTap: (){},
                ),

                // 사이렌 오더 받기 임시 중지
                ListTile(
                  leading: const Icon(Icons.event_note_outlined),
                  title: const Text('임시중지'),
                  onTap: (){},
                ),

                // 운영 시간, 전화번호, 위치
                ListTile(
                  leading: const Icon(Icons.event_note_outlined),
                  title: const Text('운영 정보'),
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const AboutUs()));
                  },
                ),

                // 사이렌 오더 알람 소리 설정, 앱 버전
                ListTile(
                  leading: const Icon(Icons.event_note_outlined),
                  title: const Text('설정'),
                  onTap: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Setting()));
                  },
                ),
              ],
            ),
          ),

          // 로그아웃
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                const Divider(thickness: 1, color: Colors.grey,),
                Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text(Strings.signOut),
                    onTap: () async {
                      _pressedSignOutButton(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _drawerHeader(BuildContext context) {
    var userName = Provider.of<UserStateProvider>(context).userName;

    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Palette.backgroundColor1
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hello,',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }


  // 로그아웃 버튼 클릭
  _pressedSignOutButton(BuildContext context) async {

    var result =  CommonDialog().showConfirmDialog('로그아웃 하시겠습니까?');

    if( await result ) {

      var isSignOut = Provider.of<UserStateProvider>((context), listen: false).signOut();

      if( await isSignOut ) {
        try {
          // 이전의 마지막 페이지 제거
          Get.off(() => const Login());
        } catch(e) {
          print('Error $e');
        }
      }
    }
  }
}