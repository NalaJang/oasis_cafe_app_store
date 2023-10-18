import 'package:flutter/material.dart';
import 'package:oasis_cafe_app_store/config/palette.dart';

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
          automaticallyImplyLeading: false,
          backgroundColor: Palette.backgroundColor1,
          elevation: 0.0,
          title: Text('Oasis cafe'),

          bottom: const TabBar(
            indicator: BoxDecoration(
              color: Colors.white
            ),
            labelColor: Colors.brown,
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


        body: Text('ddd'),
      ),
    );
  }
}
