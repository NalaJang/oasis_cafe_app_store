import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';
import 'package:oasis_cafe_app_store/screens/home/orderList.dart';

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

          bottom: const TabBar(
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
              Tab(text: '신규/처리중 0',),
              Tab(text: '완료 44',)
            ],
          ),
        ),

        drawer: myDrawer(),

        body: TabBarView(
          children: [

            const OrderList(),

            ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '13:22',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                      Text('카페 모카 외 3개'),

                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: (){},
                            child: Text(
                              '주문표 \n인쇄',
                              textAlign: TextAlign.center,
                            )
                          ),

                          SizedBox(width: 10,),

                          ElevatedButton(
                            onPressed: (){},
                            child: Text(
                                '주문 접수'
                            )
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }
            ),
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
            onTap: (){},
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
