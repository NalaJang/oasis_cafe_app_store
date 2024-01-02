import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/palette.dart';
import '../../main.dart';
import '../../provider/userStateProvider.dart';
import '../../strings/strings_en.dart';
import '../aboutUs/aboutUs.dart';

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
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Palette.backgroundColor1
                  ),
                  child: Text(
                    'Hello,\n',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                // 새 메뉴 추가, 메뉴 정보 수정, 메뉴 품절 등
                ListTile(
                  leading: Icon(Icons.event_note_outlined),
                  title: Text('메뉴 관리'),
                  onTap: (){},
                ),

                // 사이렌 오더 받기 임시 중지
                ListTile(
                  leading: Icon(Icons.event_note_outlined),
                  title: Text('임시중지'),
                  onTap: (){},
                ),

                // 운영 시간, 전화번호, 위치
                ListTile(
                  leading: Icon(Icons.event_note_outlined),
                  title: Text('운영 정보'),
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const AboutUs()));
                  },
                ),

                // 사이렌 오더 알람 소리 설정, 앱 버전
                ListTile(
                  leading: Icon(Icons.event_note_outlined),
                  title: Text('설정'),
                  onTap: (){},
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
                      var isSignOut = Provider.of<UserStateProvider>(context, listen: false).signOut();

                      if( await isSignOut ) {
                        Navigator.pushAndRemoveUntil(
                          (context),
                          MaterialPageRoute(
                            builder: (context) => const MyApp()
                          ), (route) => false
                        );
                      }
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
}