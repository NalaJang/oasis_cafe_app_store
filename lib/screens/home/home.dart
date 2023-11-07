import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';
import 'package:oasis_cafe_app_store/provider/orderStateProvider.dart';
import 'package:oasis_cafe_app_store/screens/aboutUs/aboutUs.dart';
import 'package:oasis_cafe_app_store/screens/home/orderList.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final tabBarLength = 2;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabBarLength,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.backgroundColor1,
          elevation: 0.0,
          title: Text('Oasis cafe'),

          bottom: TabBar(
            indicator: BoxDecoration(
              color: Colors.white
            ),
            labelColor: Palette.textColor1,
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal
            ),

            tabs: [
              Tab(text: '신규/처리중 ${Provider.of<OrderStateProvider>(context).getNewOrderLength()}',),
              Tab(text: '완료 ${Provider.of<OrderStateProvider>(context).getCompletedOrderLength()}',)
            ],
          ),
        ),

        drawer: myDrawer(),

        body: TabBarView(
          children: [
            for( var i = 0; i < tabBarLength; i++ )
              OrderList(currentTabIndex: i,)

          ],
        ),
      ),
    );
  }

  Drawer myDrawer() {
    return Drawer(
      child: ListView(
        children: [

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

          // 로그아웃
          ListTile(
            leading: Icon(Icons.event_note_outlined),
            title: Text('로그아웃'),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}
